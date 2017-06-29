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

exports.expressionGenerator = expressionGenerator =
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
    e = rnd.uniqueInts2Plus(9)
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
    description : "Multipliziere die Klammer aus und vereinfache:"
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
    description : "Multipliziere die Klammer aus und vereinfache:"
    checks : defaultExpressionCheck

  ausklammern : (level = 1) ->
    a = rnd.int2Plus(9)
    if level > 1
      if rnd.bool() then a = -a
      a = "#{a}#{rnd.letter()}"
    ops = rnd.opsStrich()[0..level]
    if ops[0] is "+" then ops[0] = ""
    coeffs = rnd.ints2Plus(9)
    vars = rnd.uniqueLetters()
    inner = zipper [ops, coeffs, vars]
    solution = "#{a}*(#{inner})"
    #return
    problem : nerdamer("expand(#{solution})").text "fractions"
    solution : solution
    description : "Klammere #{a} aus."
    checks : [
        Check.equivalent
        Check.firstFactorEquivalent
      ]

  ausklammernMax : (level = 1) ->
    a = rnd.int2Plus(9)
    if level > 1
      a = "#{a}#{rnd.letter()}"
    ops = rnd.opsStrich()[0..level]
    if ops[0] is "+" then ops[0] = ""
    coeffs = rnd.uniquePrimes()
    vars = rnd.uniqueLetters()
    inner = zipper [ops, coeffs, vars]
    solution = "#{a}*(#{inner})"
    #return
    problem : nerdamer("expand(#{solution})").text "fractions"
    solution : solution
    description : "Klammere so weit wie möglich aus."
    checks : [
        Check.equivalent
        Check.firstFactorEquivalent
      ]

exports.expressions =
  title : "Terme vereinfachen"
  description : "Terme zusammenfassen und Klammern ausmultiplizieren"
  problems : [
    levels : [1..3]
    generator : expressionGenerator.summeZusFass
  ,
    levels : [2..3]
    levelOffset : -1
    generator : expressionGenerator.summeZusFassExp
  ,
    levels : [3..5]
    levelOffset : -2
    generator : expressionGenerator.expandKlammer
  ,
    levels : [4..5]
    levelOffset : -3
    generator : expressionGenerator.expandKlammerKlammer
  ]

exports.ausklammern =
  title : "Faktorisieren von Summen"
  description : "Oder einfacher ausgedrückt: Ausklammern"
  problems : [
    levels : [1..2]
    generator : expressionGenerator.ausklammern
  ,
    levels: [2..3]
    levelOffset : -1
    generator : expressionGenerator.ausklammernMax
  ]
