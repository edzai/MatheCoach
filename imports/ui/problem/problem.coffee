require "./problem.jade"

_ = require "lodash"

{ Problem } = require "/imports/modules/mathproblems2/mathproblems.coffee"
{ renderAM } = require "/imports/modules/mathproblems2/renderAM.coffee"


Template.problem.viewmodel
  testAM : "1+sqrt(2a)"
  problemKey : "examples"
  problem : {}
  title : -> @problem()?.title
  description : -> @problem()?.description ? ""
  hint : -> @problem()?.hint ? ""
  problemHtml : -> renderAM @problem()?.problem ? ""
  solutionHtml : -> renderAM(@problem()?.solution ? "")
  answer : ""
  answered : false
  answerCorrect : false
  checkAnswer : ->
    @answered true
    @answerCorrect @problem().checkAnswer(@answer())
  newProblem : ->
    @answer.reset()
    @answered.reset()
    @answerCorrect.reset()
    @problem new Problem(@problemKey())
  onCreated : -> @newProblem()
