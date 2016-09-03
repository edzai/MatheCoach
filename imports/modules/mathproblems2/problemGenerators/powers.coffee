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

  test : (level = 1) ->
    [n, m] = rnd.ints(9)
    x = rnd.letter()
    [op1, op2] = switch level
      when 1 then ["", ""]
      when 2 then ["", rnd.opMinus()]
      else rnd.opsMinus()
    #returns
    problem : "#{x}^(#{op1}#{n})*#{x}^(#{op2}#{m})"
    description : "Vereinfache den Term mit dem 1. Potenzgesetz"
    hint : "'a hoch 3b' gibst du so ein: a^(3b)"

  exp1BruchNum : (level = 1) ->
    [n, m] = rnd.ints(9)
    [op1, op2] = switch level
      when 1 then ["", ""]
      when 2 then ["", rnd.opMinus()]
      else rnd.opsMinus()
    x = rnd.letter()
    #returns
    problem : "#{x}^(#{op1}#{n})/#{x}^(#{op2}#{m})"
    description : "Vereinfache den Term mit dem 1. Potenzgesetz"
    hint : "'a hoch 3b' gibst du so ein: a^(3b)"

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
