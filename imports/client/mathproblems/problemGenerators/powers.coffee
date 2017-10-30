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

exports.powersGenerator = powersGenerator =
  exp1Num : (level = 1, language="de") ->
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
    description : switch language
      when "de" then "Vereinfache den Term:"
      else "Simplify the expression"
    checks : defaultPowerCheck
    hint : "'a hoch 3b' gibst du so ein: a^(3b)"

  exp1Var : (level = 1, language="de") ->
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
    description : switch language
      when "de" then "Vereinfache den Term:"
      else "Simplify the expression"
    checks : defaultPowerCheck

  exp1NumQuotient : (level = 1, language="de") -> #exp1NumQuotient
    switch level
      when 1
        op = "*"
      else
        op = rnd.opPunkt()
    [nd, md] = rnd.ints2Plus(9)
    x = rnd.letter()
    #return
    problem : "#{x}^(1/#{nd})#{op}#{x}^(1/#{md})"
    description : switch language
      when "de" then "Vereinfache den Term:"
      else "Simplify the expression"
    checks : defaultPowerCheck

  sqrtAsPower : (level = 1, language="de") ->
    x = rnd.letter()
    n = rnd.int2Plus(9)
    magStr = if n is 2 then "" else "[#{n}]"
    #return
    problem : "#{x}^(1/#{n})"
    problemTeX : "\\sqrt#{magStr}{#{x}}"
    description : switch language
      when "de" then "Schreibe die Wurzel als Potenz:"
      else "Turn the root into an exponential:"

  sqrt1Num : (level = 1, language="de") ->
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
    description : switch language
      when "de"
        "Wandle in eine einzelne Potenz um."
      else
        "Transform the expression into a single potentiation."

  exp2Num : (level = 1, language="de") ->
    exp = rnd.int2Plus 5
    [na, nb] = rnd.uniqueIntsPlus 9-exp
    [va, vb] = rnd.uniqueLetters()
    op = rnd.opPunkt()
    drop1 = (n) -> if n is 1 then "" else "#{n}"
    switch level
      when 1
        na = rnd.int2Plus 9-exp #make sure there is something to simplify
        problem = "(#{drop1 na}#{va})^#{exp}"
      else
        problem = "((#{drop1 na}#{va})#{op}(#{drop1 nb}#{vb}))^#{exp}"
        #make a pretty solution (nerdamer's is ugly):
        if op is "/"
          bruch = math.fraction na, nb
          solution = "#{drop1 bruch.n**exp} #{va}^#{exp}/\
            (#{drop1 bruch.d**exp} #{vb}^#{exp})"
        else
          [v1, v2] = [va, vb].sort()
          solution = "#{(na*nb)**exp} #{v1}^#{exp} #{v1}^#{exp}"
    #return
    problem : problem
    solution : solution
    description : switch language
      when "de" then "Vereinfache den Term:"
      else "Simplify the expression"
    hint : switch language
      when "de"
        "In der Lösung darf keine Potenz eines \
        Klammerterms mehr vorkommen."
      else
        "The base of the exponential may not be in brackets."
    checks : [Check.equivalent, Check.noPowerOfBracket]


exports.powers =
  potenz1 :
    title :
      de : "Potenzen und Wurzeln 1"
      en : "Exponentiations and Roots 1"
    description :
      de : "Aufgaben zum 1. Potenzgesetz (gleiche Basis)."
      en : "Sums and Differences of Exponentiations with the same Base."
    problems : [
      levels : [1..3]
      generator : powersGenerator.exp1Num
    ,
      levels : [2..4]
      levelOffset : -1
      generator : powersGenerator.exp1Var
    ,
      levels : [3..5]
      levelOffset : -2
      generator : powersGenerator.exp1NumQuotient
    ,
      levels : [4]
      generator : powersGenerator.sqrtAsPower
    ,
      levels : [4..5]
      generator : powersGenerator.sqrt1Num
    ]
  potenz2 :
    title :
      de : "Potenzen und Wurzlen 2"
      en : "Exponentiations and Roots 2"
    description :
      de : "Aufgaben zum 2. Potenzgesetz (gleicher Exponent)."
      en : "Multiplying and Dividing Exponentiations with the same Exponent."
    problems : [
      levels : [1..2]
      generator : powersGenerator.exp2Num
    ]
