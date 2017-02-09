#require "/imports/client/ui-slider.css"
require "/imports/client/web/mustBeLoggedIn/mustBeLoggedIn.coffee"
require "./problem.jade"
require "/imports/client/web/moduleScoreDisplay/moduleScoreDisplay.coffee"

_ = require "lodash"

{ Problem } =
  require "/imports/client/mathproblems/mathproblems.coffee"

{ teXifyAM } =
  require "/imports/client/mathproblems/renderAM.coffee"

{ Tally } =
  require "/imports/modules/tally.coffee"


{ Submissions, resetSubmissions, insertSubmission } =
  require "/imports/api/submissions.coffee"

Template.inputKey.viewmodel

Template.problem.viewmodel
  share : ["reactiveTimer", "unsyncedSubmissions"]
  isMobile : false
  handleInputKey : (keyValue) ->
    strArray = @answer().split ""
    if keyValue is "backspace"
      strArray.pop()
    else
      strArray.push keyValue
    @answer strArray.join("")
  inputKeys : ->
    numberKeys = [0..9].map (i) ->
      text : "#{i}"
      value : "#{i}"
    operatorKeys = "+-*/^=()".split("").map (e) ->
      text : e
      value : e
    .concat [
      text : "√"
      value : "sqrt("
    ,
      text : "⌫"
      value : "backspace"
    ]
    letterKeys = _(@problem()?.solution?.match /[a-z]/gi)
      .uniq()
      .sort()
      .value()
      .map (e) ->
        text : e
        value : e
    numberKeys.concat operatorKeys, letterKeys
  moduleKey : -> FlowRouter.getParam "key"
  userId : -> Meteor.userId()
  problem : {}
  threeDaysAgo : ->
    @tick()
    moment().subtract(3, "days").toDate()
  levelTally : ->
    new Tally
      userId : Meteor.userId()
      moduleKey : @moduleKey()
      level : @currentLevel()
      date :
        $gt : @threeDaysAgo()
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
      resetSubmissions.call
        moduleKey : @moduleKey()

  checkAnswer : ->
    if @answered()
      @newProblem()
    else
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
        @insertSubmission
          moduleKey : @moduleKey()
          level : @currentLevel()
          answerCorrect : @answerCorrect()
          description : @description()
          problem : @problemTeX()
          answer : @answer()
          date : new Date()

  currentPerc :  ->
    @levelTally().rightPercent() *
    @levelTally().rightCount() * @currentLevel()

  retryCountdown : 0
  autoLevel : ->
    if @autoLevelOn()
      unless @loggedIn()
        @autoLevelOn false
      else
        if @levelTally().rightPercent() > 79 and
        @levelTally().rightCount() > 4 and
        @answerCorrect()
          if @retryCountdown() < 1
            @newLevel @currentLevel() + 1
          else
            @retryCountdown @retryCountdown() - 1
        if @levelTally().rightPercent() < 60 and not @answerCorrect()
          @newLevel @currentLevel() - 1
          @retryCountdown 3

  newProblem : ->
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
  harder : ->
    @newLevel @currentLevel() + 1
    @newProblem()
  easier : ->
    @newLevel Math.max( 1, @currentLevel() - 1)
    @newProblem()
