{ Rnd } = require "../randomGenerators.coffee"
rnd = new Rnd()

{ Check } = require "../checks.coffee"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

math = require "mathjs"

defaultExpressionCheck = [
  Check.equivalent
  Check.summandsEquivalent
]

zipper = (arrays) ->
  (for e, i in arrays[0]
    (for a in arrays
      a[i]
    ).join ""
  ).join ""

exports.expressionGenerator =

  summeZusFass : (level = 1) ->
    n = Math.min 3, level
    v = rnd.uniqueLetters()
    bits = (
      for i in [1..n]
        for j in [1..2]
          op = rnd.opStrich()
          c = rnd.intPlus()
          "#{op}#{c}#{v[i]}"
    )
    problem = _.chain(bits).flatten().shuffle().value().join("")
      .split("")[1..].join("")
    #return
    problem : problem
    description : "Vereinfache den Term:"
    checks : defaultExpressionCheck

  summeZusFassExp : (level = 1) ->
    n = Math.min 3, level
    e = rnd.uniqueInts(9)
    x = rnd.letter()
    bits = (
      for i in [1..n]
        for j in [1..2]
          op = rnd.opStrich()
          c = rnd.intPlus()
          "#{op}#{c}#{x}^#{e[i]}"
    )
    problem = _.chain(bits).flatten().shuffle().value().join("")
      .split("")[1..].join("")
    #return
    problem : problem
    description : "Vereinfache den Term:"
    checks : defaultExpressionCheck

  expandKlammer : (level = 1) ->
    a = rnd.int2Plus(9)
    ops = rnd.opsStrich()[0..level]
    if ops[0] is "+" then ops[0] = ""
    coeffs = rnd.ints2Plus(9)
    vars = rnd.letters()
    inner = zipper [ops, coeffs, vars]
    problem = "#{a}*(#{inner})"
    #return
    problem : problem
    solution : nerdamer("expand(#{problem})").text "fractions"
    description : "Multipliziere die Klammer aus:"
    checks : defaultExpressionCheck

  expandKlammerKlammer : (level = 1) ->
    [x, y] = rnd.uniqueLetters()
    [a, b, c, d] = rnd.intsPlus(9)
    [op1, op2 ]= rnd.opsStrich()
    if level < 2 then y = x
    problem = "(#{rnd.coeffify a}#{x}#{op1}#{b})*\
      (#{rnd.coeffify c}#{y}#{op2}#{d})"
    #return
    problem : problem
    solution : nerdamer("expand(#{problem})").text "fractions"
    description : "Multipliziere die Klammer aus:"
    checks : defaultExpressionCheck
