require "/imports/ui/ui-slider.css"
require "./problem.jade"
require "/imports/ui/moduleScoresDisplay/moduleScoresDisplay.coffee"

_ = require "lodash"

{ Problem } =
  require "/imports/modules/mathproblems2/mathproblems.coffee"

{ teXifyAM } =
  require "/imports/modules/mathproblems2/renderAM.coffee"

{ ModuleScores, updateModuleScores,
  LevelScores, updateLevelScores, resetLevelScores
} =
  require "/imports/api/collections.coffee"

Template.problem.viewmodel
  moduleKey : -> FlowRouter.getParam "key"
  problem : {}
  levelScores : ->
    LevelScores.findOne
      userId : Meteor.userId()
      moduleKey : @moduleKey()
      level : @currentLevel()
  title : -> @problem()?.title
  maxLevel : -> @problem().maxLevel
  minLevel : -> @problem().minLevel
  currentLevel : -> @problem().level
  newLevel : 1
  description : -> @problem()?.description ? ""
  hint : -> @problem()?.hint ? ""
  passTextsRequired : []
  passTextsOptional : []
  failTextsRequired : []
  failTextsOptional : []
  problemTeX : -> @problem()?.problemTeX
  solutionTeX : -> @problem()?.solutionTeX
  loggedIn : -> Meteor.userId() isnt null
  autoLevelOn : false
  answer : ""
  answered : false
  answerCorrect : false
  focusOnAnswer : true
  showPreview : false
  previewIconClass : -> if @showPreview() then "hide" else "unhide"
  preview : ->
    try
      teXifyAM @problem().answerPreprocessor(@answer())
    catch error
      "\\text{#{error.message}}"

  resetData : ->
    if confirm "Wirklich die Punktestände für dieses Modul löschen?"
      resetLevelScores.call
        moduleKey : @moduleKey()

  checkAnswer : ->
    unless @answered()
      @answered true
      { pass, passTextsRequired, passTextsOptional,
        failTextsRequired, failTextsOptional } =
        @problem().checkAnswer(@answer())
      @answerCorrect pass
      @passTextsRequired passTextsRequired
      @passTextsOptional passTextsOptional
      @failTextsRequired failTextsRequired
      @failTextsOptional failTextsOptional
      if Meteor.userId()
        updateLevelScores.call
          moduleKey : @moduleKey()
          level : @currentLevel()
          answerCorrect : @answerCorrect()
          problem : @problemTeX()
          answer : @answer()
    else
      @newProblem()

  levelPerc : ->
    recent = @levelScores()?.recent
    if recent?
      rightCount =
        _(recent)
          .map (dataPoint) -> dataPoint.answerCorrect
          .filter (answerCorrect) -> answerCorrect
          .value().length
      totalCount = recent.length or 1
      rightPercent = Math.round rightCount/totalCount*100
      Math.round rightCount/Math.max(totalCount, 5)*100
    else null

  currentPerc : ->
    cursor = LevelScores.find
      userId : Meteor.userId()
      moduleKey : @moduleKey()
    result = 0
    for doc in cursor.fetch()
      totalCount = doc.recent.length
      rightCount = _(doc.recent)
        .map (dataPoint) -> dataPoint.answerCorrect
        .filter (e) -> e
        .value().length
      result += Math.round(rightCount/Math.max(totalCount, 5)* 100 * doc.level)
    result

  retryCountdown : 0
  autoLevel : ->
    if @autoLevelOn()
      unless @loggedIn()
        @autoLevelOn false
      else
        if @levelPerc() > 79 and
        @currentLevel() < @maxLevel() and
        @answerCorrect()
          if @retryCountdown() < 1
            @newLevel @currentLevel() + 1
          else
            @retryCountdown @retryCountdown() - 1
        if @levelPerc() < 60 and not @answerCorrect()
          @currentLevel() > @minLevel()
          @newLevel @currentLevel() - 1
          @retryCountdown 3

  newProblem : ->
    unless @answered()
      if Meteor.userId()
        updateModuleScores.call
          moduleKey : @moduleKey()
          answerCorrect : false
    @autoLevel()
    @answer.reset()
    @answered.reset()
    @answerCorrect.reset()
    @passTextsRequired.reset()
    @passTextsOptional.reset()
    @failTextsRequired.reset()
    @failTextsOptional.reset()
    @problem new Problem(@moduleKey(), @newLevel())
    @newLevel @currentLevel()
  gotoModulesList : -> FlowRouter.go "/"
  onCreated : ->
    @problem new Problem(@moduleKey(), @newLevel())
    @newLevel @currentLevel()
  area51 : -> @moduleKey() is "test"
  harder : ->
    @newLevel @currentLevel() + 1
    @newProblem()
  easier : ->
    @newLevel Math.max( 1, @currentLevel() - 1)
    @newProblem()
