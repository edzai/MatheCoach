_ = require "lodash"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

math = require "mathjs"

{ renderAM } = require "./renderAM.coffee"
{ Rnd } = require "./randomGenerators.coffee"

{ problemDefinitions } = require "./problemDefinitions.coffee"


class Problem
  constructor : (@moduleKey) ->
    @title = problemDefinitions[@moduleKey].title
    { @problem, @solution, @form, @description, @hint } =
      (_.sample problemDefinitions[@moduleKey].problems)()
    @solution ?= nerdamer(@problem).text("fractions")

  checkAnswer : (answer) ->
    solution = @solution
    if "=" in solution.split ""
      solution = solution.split("=")[1]
    if "=" in answer.split ""
      answer = answer.split("=")[1]
    equivalent = nerdamer("(#{answer}) - (#{solution})").text() is "0"
    formCorrect = true
    if @form?
      formCorrect = @form.test answer
    fractionRe = /(\d+)\s?\*?\s?[a-z]*\s?\/\s?(\d+)\s?\*?\s?[a-z]*/g
    reducableFractions = false
    while result = fractionRe.exec answer
      [fraction, numeratorStr, denominatorStr] = result
      numerator = Number(numeratorStr)
      denominator = Number(denominatorStr)
      unless math.gcd(numerator, denominator) is 1
        reducableFractions = true
    #return
    equivalent : equivalent
    formCorrect : formCorrect
    reducableFractions : reducableFractions


exports.Problem = Problem
