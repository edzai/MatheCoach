{ Rnd } = require "../randomGenerators.coffee"
rnd = new Rnd()

{ Check } = require "../checks.coffee"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

math = require "mathjs"

checks = [Check.equivalent, Check.isWholePositiveNumber]

exports.einXeinsGenerator =
  multiplikation : (level = 1) ->
    switch level
      when 1
        [a, b] = rnd.intsMin 1, 10
      when 2
        a = rnd.int2Plus(9)
        b = rnd.intMin 11, 20
        if rnd.bool() then [a, b] = [b, a]
      else
        [a, b] = rnd.intsMin 11, 20
    #return
    problem : "#{a}*#{b}"
    description : "Multipliziere die zwei Ganzen Zahlen:"
    checks : checks

  division : (level = 1) ->
    switch level
      when 1
        [a, b] = rnd.intsMin 1, 10
      when 2
        a = rnd.int2Plus(9)
        b = rnd.intMin 11, 20
        if rnd.bool() then [a, b] = [b, a]
      else
        [a, b] = rnd.intsMin 11, 20
    #return
    problem : "#{a}"
    problemTeX : "#{a*b}\\div#{b}"
    description : "Teile durch die Ganze Zahl:"
    checks : checks
