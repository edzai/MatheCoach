_ = require "lodash"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

math = require "mathjs"

{ renderAM } = require "./renderAM.coffee"
{ Rnd } = require "./randomGenerators.coffee"
{ Check } = require "./checks.coffee"

{ problemDefinitions } = require "./problemDefinitions.coffee"


class Problem
  constructor : (@moduleKey, @level = 1) ->
    @level = Number @level
    problems = problemDefinitions[@moduleKey].problems
    availableLevels = _(problems).map("levels").flatten().uniq().value()
    @maxLevel = _.max availableLevels
    @minLevel = _.min availableLevels
    unless @level in availableLevels
      @level = if @level > @maxLevel then @maxLevel else @minLevel
    @title = problemDefinitions[@moduleKey].title
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
      @description, @hint
      @checks
    } = sample?.generator generatorLevel
    @solution ?= nerdamer(@problem).text "fractions"
    @checks ?= [Check.equivalent, Check.noReducableFractionsOptional]

  checkAnswer : (answer) ->
    solution = @solution
    if "=" in solution.split ""
      solution = solution.split("=")[1]
    if "=" in answer.split ""
      answer = answer.split("=")[1]
    pass = true
    passTextsRequired = []
    passTextsOptional = []
    failTextsRequired = []
    failTextsOptional = []
    for check in @checks
      if check.pass answer, solution
        if check.required
          if check.passText?
            passTextsRequired.push check.passText
        else
          if check.passText?
            passTextsOptional.push check.passText
      else
        if check.required
          pass = false
          if check.failText?
            failTextsRequired.push check.failText
        else
          if check.failText?
            failTextsOptional.push check.failText
    #return
    pass : pass
    passTextsRequired : passTextsRequired
    passTextsOptional : passTextsOptional
    failTextsRequired : failTextsRequired
    failTextsOptional : failTextsOptional

exports.Problem = Problem
