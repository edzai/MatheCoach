_ = require "lodash"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

math = require "mathjs"

{ teXifyAM } = require "./renderAM.coffee"
{ Rnd } = require "./randomGenerators.coffee"
{ Check } = require "./checks.coffee"
{ AMString } = require "./AMString.coffee"

{ problemDefinitions } = require "./problemDefinitions.coffee"

defaultAnswerPreprocessor = (answer) ->
  str = new AMString answer
  str
    .markReserved()
    .removeWhitespace()
    .productify()
    .unmarkReserved()
    .value()

defaultLaTeXPostProcessor = (tex) ->
  str = new AMString tex
  str
    .removeCDots()
    .value()

class Problem
  constructor : (@moduleKey, @level = 1, @language="de") ->
    @level = Number @level
    problems = problemDefinitions[@moduleKey].problems
    availableLevels = _(problems).map("levels").flatten().uniq().value()
    @maxLevel = _.max availableLevels
    @minLevel = _.min availableLevels
    unless @level in availableLevels
      @level = if @level > @maxLevel then @maxLevel else @minLevel
    @title =
      problemDefinitions[@moduleKey].title[@language] ?
      problemDefinitions[@moduleKey].title.de
    sample =
      _(problems)
        .filter (elem) => @level in elem.levels
        .sample()
    @levelOffset = sample?.levelOffset ? 0
    generatorLevel = @level + @levelOffset
    if generatorLevel < 1 then generatorLevel = 1
    {
      @problem, @problemTeX,
      @solution, @solutionTeX,
      @description, @hint,
      @textBook,
      @score
      @skipExpression,
      @geometryDrawData,
      @functionPlotData,
      @customTemplateName, @customTemplateData, @templateReturnsAnswer
      @checks
      @answerPreprocessor
      @laTeXPostProcessor
      @isSystemOfLinearEquations
    } = sample?.generator generatorLevel, @language
    @laTeXPostProcessor ?= defaultLaTeXPostProcessor
    @problemTeX ?= teXifyAM @problem
    @problemTeX = @laTeXPostProcessor @problemTeX
    @solution ?= nerdamer(@problem).text "fractions"
    @solutionTeX ?= teXifyAM @solution
    @solutionTeX = @laTeXPostProcessor @solutionTeX
    @score ?= 1
    @checks ?= [
      Check.equivalent
      Check.noReducableFractionsOptional
      #Check.leftSideOptionalExactFit
    ]
    @answerPreprocessor ?= defaultAnswerPreprocessor

  checkAnswer : (answerString) ->
    arrayify = (inputString) ->
      inputString
      .split ","
      .map (str) ->
        unless "=" in str.split("")
          sortString : nerdamer(str).text "fractions"
          leftSide : undefined
          rightSide : str
        else
          [leftSide, rightSide] = str.split "="
          sortString : nerdamer(leftSide).text "fractions"
          leftSide : leftSide
          rightSide : rightSide
      .sort (a,b) ->
        if a.sortString < b.sortString then -1 else 1
    answers = arrayify @answerPreprocessor(answerString)
    solutions = arrayify @answerPreprocessor(@solution)
    pass = true
    passTextsRequired = []
    passTextsOptional = []
    failTextsRequired = []
    failTextsOptional = []
    if answers.length isnt solutions.length
      pass = false
      wrongNumberOfResultsText = switch @language
        when "de" then "Die Anzahl der Lösungen stimmt nicht."
        else "The number of solutions is wrong."
      failTextsRequired = []
    else
      for solution, i in solutions
        for check in @checks
          if check.pass(
            answers[i].rightSide, solution.rightSide,
            answers[i].leftSide, solution.leftSide
          )
            if check.required
              if check.passText?
                passTextsRequired.push (check.passText[@language] ? check.passText.de)
            else
              if check.passText?
                passTextsOptional.push (check.passText[@language] ?
                  check.passText.de)
          else
            if check.required
              pass = false
              if check.failText?
                failTextsRequired.push (check.failText[@language] ?
                  check.failText.de)
            else
              if check.failText?
                failTextsOptional.push (check.failText[@language] ?
                  check.failText.de)
    #return
    pass : pass
    passTextsRequired : passTextsRequired
    passTextsOptional : passTextsOptional
    failTextsRequired : failTextsRequired
    failTextsOptional : failTextsOptional

exports.Problem = Problem
