{ Rnd } = require "../randomGenerators.coffee"
rnd = new Rnd()

{ Check } = require "../checks.coffee"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

math = require "mathjs"

checks = [Check.equivalent, Check.isWholePositiveNumber]

exports.einXeinsGenerator = einXeinsGenerator =
  multiplikation : (level = 1, language="de") ->
    switch level
      when 1
        [a, b] = rnd.ints2Plus 9
      when 2
        a = rnd.int2Plus 9
        b = rnd.intMin 11, 20
        if rnd.bool() then [a, b] = [b, a]
      else
        [a, b] = rnd.intsMin 11, 20
    #return
    problem : "#{a}*#{b}"
    description : "Multipliziere die zwei Ganzen Zahlen:"
    checks : checks

  division : (level = 1, language="de") ->
    switch level
      when 1
        [a, b] = rnd.ints2Plus 9
      when 2
        a = rnd.int2Plus 9
        b = rnd.intMin 11, 20
        if rnd.bool() then [a, b] = [b, a]
      else
        [a, b] = rnd.intsMin 11, 20
    #return
    problem : "#{a}"
    problemTeX : "#{a*b}\\div#{b}"
    description : "Teile durch die Ganze Zahl:"
    checks : checks

exports.einXeins =
  title :
    de : "1 x 1"
  description :
    de : "Multiplikation und Division mit Ganzen Zahlen"
  problems : [
    levels : [1..4]
    generator : einXeinsGenerator.multiplikation
  ,
    levels : [2..4]
    levelOffset : -1
    generator : einXeinsGenerator.division
  ]
