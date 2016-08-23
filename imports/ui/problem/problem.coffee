require "/imports/ui/ui-slider.css"
require "./problem.jade"
require "/imports/ui/moduleScoresDisplay/moduleScoresDisplay.coffee"

_ = require "lodash"

{ Problem } =
  require "/imports/modules/mathproblems2/mathproblems.coffee"

{ renderAM, renderTeX } =
  require "/imports/modules/mathproblems2/renderAM.coffee"

{ ModuleScores, updateModuleScores,
  LevelScores, updateLevelScores, resetLevelScores
} =
  require "/imports/api/collections.coffee"

Template.problem.viewmodel
  testAM : ""
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
  autoLevelOn : -> not @area51()
  description : -> @problem()?.description ? ""
  hint : -> @problem()?.hint ? ""
  problemHtml : ->
    if @problem()?.problemTeX?
      renderTeX @problem().problemTeX
    else
      renderAM @problem()?.problem ? ""
  solutionHtml : ->
    if @problem()?.solutionTeX?
      renderTeX @problem().solutionTeX
    else
      renderAM @problem()?.solution ? ""
  answered : false
  answerCorrect : false
  formCorrect : false
  reducableFractions : false
  focusOnAnswer : true
  nextButtonClass : -> if @answered() then "green" else "red"

  resetData : ->
    if confirm "Wirklich die Punktestände für dieses Modul löschen?"
      resetLevelScores.call
        moduleKey : @moduleKey()

  checkAnswer : ->
    unless @answered()
      @answered true
      { equivalent, formCorrect, reducableFractions } =
        @problem().checkAnswer(@answer())
      @answerCorrect equivalent
      @formCorrect formCorrect
      @reducableFractions reducableFractions
      if Meteor.userId()
        updateLevelScores.call
          moduleKey : @moduleKey()
          level : @currentLevel()
          result : @answerCorrect()
    else
      @newProblem()

  levelPerc : ->
    recent = @levelScores()?.recent
    if recent?
      rightCount =
        _(recent)
          .filter (e) -> e
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
        .filter (e) -> e
        .value().length
      result += Math.round(rightCount/Math.max(totalCount, 5)* 100 * doc.level)
    result

  maxCurrentPerc : -> (@maxLevel() - @minLevel() + 1) * 100
  retryCountdown : 0
  autoLevel : ->
    if @autoLevelOn()
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
    @formCorrect.reset()
    @reducableFractions.reset()
    @focusOnAnswer.reset()
    @problem new Problem(@moduleKey(), @newLevel())
    @newLevel @currentLevel()
  gotoModulesList : -> FlowRouter.go "/"
  onCreated : ->
    @problem new Problem(@moduleKey(), @newLevel())
    @newLevel @currentLevel()
  area51 : -> @moduleKey() is "test"
  newProblemTest : ->
    @newLevel (@currentLevel() % 5) + 1
    @newProblem()
  # autorun : [
  #   -> console.log "newLevel", @newLevel()
  #   -> console.log "retryCountdown", @retryCountdown()
  # ]
