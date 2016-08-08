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
    nerdamer("#{answer} - #{solution}").text() is "0"


exports.Problem = Problem
