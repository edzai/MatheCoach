require "./problem.jade"
require "/imports/ui/moduleScoresDisplay/moduleScoresDisplay.coffee"

_ = require "lodash"

{ Problem } = require "/imports/modules/mathproblems2/mathproblems.coffee"
{ renderAM } = require "/imports/modules/mathproblems2/renderAM.coffee"

{ ModuleScores, updateModuleScores } = require "/imports/api/collections.coffee"

Template.problem.viewmodel
  testAM : ""
  moduleKey : -> FlowRouter.getParam "key"
  problem : {}
  moduleScores : ->
    ModuleScores.findOne
      userId : Meteor.userId()
      moduleKey : @moduleKey()
  title : -> @problem()?.title
  description : -> @problem()?.description ? ""
  hint : -> @problem()?.hint ? ""
  problemHtml : -> renderAM @problem()?.problem ? ""
  solutionHtml : -> renderAM(@problem()?.solution ? "")
  answer : ""
  answered : false
  answerCorrect : false
  checkAnswer : ->
    if @answered()
      @answered true
      @answerCorrect @problem().checkAnswer(@answer())
      if Meteor.userId()
        updateModuleScores.call
          moduleKey : @moduleKey()
          answerCorrect : @answerCorrect()
  newProblem : ->
    unless @answered()
      if Meteor.userId()
        updateModuleScores.call
          moduleKey : @moduleKey()
          answerCorrect : false
    @answer.reset()
    @answered.reset()
    @answerCorrect.reset()
    @problem new Problem(@moduleKey())
  gotoModulesList : -> FlowRouter.go "/"
  onCreated : -> @problem new Problem(@moduleKey())
