{ Rnd } = require "../randomGenerators.coffee"
rnd = new Rnd()

{ Check } = require "../checks.coffee"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

math = require "mathjs"

defaultPowerCheck = [
  Check.equivalent
  Check.isSinglePower
]

exports.powersGenerator =

  exp1Num : (level = 1) ->
    [n, m] = rnd.intsPlus(9)
    switch level
      when 1
        [op1, op2, op3] = ["*", "", ""]
      when 2
        if rnd.bool()
          op1 = rnd.opPunkt()
          [op2, op3] = ["", ""]
        else
          op1 = "*"
          [op2, op3] = rnd.opsMinus()
      else
        op1 = rnd.opPunkt()
        [op2, op3] = rnd.opsMinus()
        [n, m] = rnd.ints()
    x = rnd.letter()
    #return
    problem : "#{x}^(#{op2}#{n})#{op1}#{x}^(#{op3}#{m})"
    description : "Vereinfache den Term:"
    checks : defaultPowerCheck
    hint : "'a hoch 3b' gibst du so ein: a^(3b)"

  exp1Var : (level = 1) ->
    [n, m] = rnd.ints2Plus(9)
    [x, nx, mx] = rnd.uniqueLetters()
    switch level
      when 1
        [op1, op2, op3] = ["*", "", ""]
        mx = nx
      when 2
        if rnd.bool()
          op1 = rnd.opPunkt()
          [op2, op3] = ["", ""]
        else
          op1 = "*"
          [op2, op3] = rnd.opsMinus()
      else
        op1 = rnd.opPunkt()
        [op2, op3] = rnd.opsMinus()
        [n, m] = rnd.ints()
    #return
    problem : "#{x}^(#{op2}#{n}#{nx})#{op1}#{x}^(#{op3}#{m}#{mx})"
    description : "Vereinfache den Term:"
    checks : defaultPowerCheck
    hint : "'a hoch 3b' gibst du so ein: a^(3b)"

  exp1NumQuotient : (level = 1) -> #exp1NumQuotient
    switch level
      when 1
        op = "*"
      else
        op = rnd.opPunkt()
    [nd, md] = rnd.ints2Plus(9)
    x = rnd.letter()
    #return
    problem : "#{x}^(1/#{nd})#{op}#{x}^(1/#{md})"
    description : "Vereinfache den Term mit dem 1. Potenzgesetz:"
    checks : defaultPowerCheck
    hint : "'a hoch 3b' gibst du so ein: a^(3b)"

  sqrtAsPower : (level = 1) ->
    x = rnd.letter()
    n = rnd.int2Plus(9)
    magStr = if n is 2 then "" else "[#{n}]"
    #return
    problem : "#{x}^(1/#{n})"
    problemTeX : "\\sqrt#{magStr}{#{x}}"
    description : "Schreibe die Wurzel als Potenz:"

  sqrt1Num : (level = 1) ->
    x = rnd.letter()
    [n, m] = rnd.ints2Plus(9)
    [magStrN, magStrM] = (
      for i in [n, m]
        if i is 2 then "" else "[#{i}]"
    )
    op = switch level
      when 1 then "*"
      else rnd.opPunkt()
    resultOp = switch op
      when "*" then "+"
      else "-"
    resultFrac = nerdamer("1/#{n}#{resultOp}1/#{m}").text "fractions"
    #return
    problem : "#{x}^(1/#{n})#{op}#{x}^(1/#{m})"
    solution : "#{x}^(#{resultFrac})"
    problemTeX : switch op
      when "*" then "\\sqrt#{magStrN}{#{x}}\\cdot\\sqrt#{magStrM}{#{x}}"
      else "\\frac{\\sqrt#{magStrN}{#{x}}}{\\sqrt#{magStrM}{#{x}}}"
    description : "Wende das 1. Potenzgesetz an und \
      schreibe das Ergebnis als Potenz:"
