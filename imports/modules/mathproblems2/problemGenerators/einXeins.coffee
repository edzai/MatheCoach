{ Rnd } = require "../randomGenerators.coffee"
rnd = new Rnd()

{ Check } = require "../checks.coffee"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

math = require "mathjs"

checks = [Check.equivalent, Check.isWholePositiveNumber]

exports.einXeinsGenerator =
  multiplikation : (level = 1) ->
    maxN = switch level
      when 1 then 9
      when 2 then 15
      when 3 then 20
    [a, b] = rnd.intsPlus(maxN)
    #return
    problem : "#{a}*#{b}"
    description : "Multipliziere die zwei Ganzen Zahlen:"
    checks : checks

  division : (level = 1) ->
    maxN = switch level
      when 1 then 9
      when 2 then 15
      when 3 then 20
    [a, b] = rnd.intsPlus(maxN)
    #return
    problem : "#{a}"
    problemTeX : "#{a*b}\\div#{b}"
    description : "Teile durch die Ganze Zahl:"
    checks : checks
