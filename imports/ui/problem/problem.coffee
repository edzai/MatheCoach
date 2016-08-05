require "./problem.jade"
{ getProblem, checkAnswer } =
  require "/imports/modules/mathproblems/getproblem.coffee"
_ = require "lodash"

Template.problem.viewmodel
  title : "Aufgabe A1"
  description : "Löse folgende Aufgabe:"
  problemAM: ""
  solutionAM : ""
  problemHtml : ""
  solutionHtml : ""
  answer : ""
  answered : false
  answerCorrect : false
  checkAnswer : ->
    @answered true
    @answerCorrect checkAnswer
      answer : @answer()
      solution : @solutionAM()
  newProblem : ->
    module = _.sample ["modul1", "modul2"]
    problem = getProblem(module)
    @title problem.title
    @description problem.description
    @problemAM  problem.problemAM
    @solutionAM  problem.solutionAM
    @problemHtml problem.problemHtml
    @solutionHtml problem.solutionHtml
    @answer.reset()
    @answered.reset()
    @answerCorrect.reset()
  onCreated : -> @newProblem()
