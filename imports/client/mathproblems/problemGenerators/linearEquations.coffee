{ Rnd } = require "../randomGenerators.coffee"
rnd = new Rnd()

{ re } = require "../RegExs.coffee"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

math = require "mathjs"

exports.linearEquationGenerator = linearEquationGenerator =

  linGl1 : (level = 1, language="de") ->
    switch level
      when 1
        x = "x"
        maxN = 9
      else
        x = rnd.letter()
        maxN = 20
    a = rnd.intPlus maxN
    b = rnd.int maxN
    op = rnd.opStrich()
    problem = "#{x}#{op}#{a}=#{b}"
    #return
    problem : problem
    solution : "#{x}=" + nerdamer.solveEquations(problem, x).toString()
    description : switch language
      when "de" then "Löse die Gleichung für #{x}:"
      else "Solve the equation for #{x}:"

  linGl2 : (level = 1, language="de") ->
    switch level
      when 1
        x = "x"
        maxN = 9
      else
        x = rnd.letter()
        maxN = 20
    a = rnd.int2Plus maxN
    b = rnd.int maxN
    problem = "#{a}#{x}=#{b}"
    #return
    problem : problem
    solution : "#{x}=" + nerdamer.solveEquations(problem, x).toString()
    description : switch language
      when "de" then "Löse die Gleichung für #{x}:"
      else "Solve the equation for #{x}:"

  linGl3 : (level = 1, language="de") ->
    switch level
      when 1
        x = "x"
        maxN = 9
      else
        x = rnd.letter()
        maxN = 20
    a = rnd.intPlus maxN
    b = rnd.int2Plus maxN
    c = rnd.int maxN
    op1 = rnd.opMinus()
    op2 = rnd.opStrich()
    op3 = rnd.opMinus()
    problem = "#{op1}#{a}#{op2}#{b}#{x}=#{op3}#{c}"
    #return
    problem : problem
    solution : "#{x}=" + nerdamer.solveEquations(problem, x).toString()
    description : switch language
      when "de" then "Löse die Gleichung für #{x}:"
      else "Solve the equation for #{x}:"

  linGl4 : (level = 1, language="de") ->
    switch level
      when 1
        x = "x"
        maxN = 9
      else
        x = rnd.letter()
        maxN = 20
    op1 = rnd.opMinus()
    op2 = rnd.opStrich()
    op3 = rnd.opMinus()
    op4 = rnd.opStrich()
    [a, c] = rnd.intsPlus maxN
    [b, d] = rnd.uniqueInts2Plus maxN
    problem = "#{op1}#{a}#{op2}#{b}#{x}=#{op3}#{c}#{op4}#{d}#{x}"
    #return
    problem : problem
    solution : "#{x}=" + nerdamer.solveEquations(problem, x).toString()
    description : switch language
      when "de" then "Löse die Gleichung für #{x}:"
      else "Solve the equation for #{x}:"

  linGl5 : (level = 1, language="de") ->
    switch level
      when 1
        x = "x"
        maxN = 9
      else
        x = rnd.letter()
        maxN = 20
    op1 = rnd.opMinus()
    op2 = rnd.opStrich()
    op3 = rnd.opMinus()
    op4 = rnd.opStrich()
    [a, c] = rnd.uniqueInts2Plus maxN
    [b, d] = rnd.intsPlus maxN
    problem = "#{op1}#{a}*(#{x}#{op2}#{b})=#{op3}#{c}*(#{x}#{op4}#{d})"
    #return
    problem : problem
    problemTeX :"#{op1}#{a}(#{x}#{op2}#{b})=#{op3}#{c}(#{x}#{op4}#{d})"
    solution : "#{x}=" + nerdamer.solveEquations(problem, x).toString()
    description : switch language
      when "de" then "Löse die Gleichung für #{x}:"
      else "Solve the equation for #{x}:"

  linGl6 : (level = 1, language="de") ->
    switch level
      when 1
        x = "x"
        maxN = 9
      else
        x = rnd.letter()
        maxN = 20
    [op1, op2, op3, op4] = (rnd.opStrich() for i in [1..4])
    [c, e] = rnd.uniqueInts2Plus maxN
    [a, b, d, f] = rnd.intsPlus maxN
    problem = "#{a}#{op1}(#{b}#{op2}#{c}#{x})=#{d}#{op3}(#{e}#{x}#{op4}#{f})"
    #return
    problem : problem
    problemTeX : problem #keep brackets
    solution : "#{x}=" + nerdamer.solveEquations(problem, x).toString()
    description : switch language
      when "de" then "Löse die Gleichung für #{x}:"
      else "Solve the equation for #{x}:"

  linGl7 : (level = 1, language="de") ->
    switch level
      when 1
        x = "x"
        maxN = 9
      when 2
        x = rnd.letter()
        maxN = 15
      else
        x = rnd.letter()
        maxN = 20
    [a, c, e] = rnd.uniqueInts2Plus maxN
    [b, d] = rnd.intsPlus maxN
    op1 = rnd.opStrich()
    op2 = rnd.opStrich()
    head = rnd.bool()
    leftSide = "#{a}*(#{x}#{op1}#{b})"
    leftSideTeX = "#{a}(#{x}#{op1}#{b})"
    rightSide = "(#{c}#{x}#{op2}#{d})/#{e}"
    rightSideTeX ="\\frac{#{c}#{x}#{op2}#{d}}{#{e}}"
    if head then [leftSideTeX, rightSideTeX] = [rightSideTeX, leftSideTeX]
    problem = "#{leftSide}=#{rightSide}"
    #return
    problem : problem
    problemTeX : "#{leftSideTeX}=#{rightSideTeX}"
    solution : "#{x}=" + nerdamer.solveEquations(problem, x).toString()
    description : switch language
      when "de" then "Löse die Gleichung für #{x}:"
      else "Solve the equation for #{x}:"

  linGl8 : (level = 1, language="de") ->
    findC = (a, b, maxN) ->
      c = rnd.intPlus maxN
      unless c in [2*a-b, 2*a+b, -(2*a-b), -(2*a+b)]
        c
      else
        findC a, b, maxN

    switch level
      when 1
        x = "x"
        maxN = 9
      else
        x = rnd.letter()
        maxN = 15
    [a, b] = rnd.intsPlus maxN
    c = findC a, b, maxN
    op1 = rnd.opStrich()
    op2 = rnd.opStrich()
    op3 = rnd.opStrich()
    head = rnd.bool()
    leftSide = "(#{x}#{op1}#{a})^2"
    rightSide = "(#{x}#{op2}#{b})*(#{x}#{op3}#{c})"
    if head then [leftSide, rightSide] = [rightSide, leftSide]
    problem = "#{leftSide}=#{rightSide}"
    #nerdamer wants the polynomials expanded
    leftPoly = nerdamer("expand(#{leftSide})").text()
    rightPoly = nerdamer("expand(#{rightSide})").text()
    polyProblem = "#{leftPoly}=#{rightPoly}"
    #return
    problem : problem
    solution : "#{x}=" + nerdamer.solveEquations(polyProblem, x).toString()
    description : switch language
      when "de" then "Löse die Gleichung für #{x}:"
      else "Solve the equation for #{x}:"

  linGl9 : (level = 1, language="de") ->
    findD = (b, c, maxN) ->
      dn = rnd.intPlus maxN
      dd = rnd.int2Plus maxN
      d = "#{dn}/#{dd}"
      foundOne = true
      forbiddenDs = [
        "2*#{b}-#{c}"
        "2*#{b}+#{c}"
        "-(2*#{b}-#{c})"
        "-(2*#{b}+#{c})"
      ]
      for elem in forbiddenDs
        if nerdamer("#{d}-#{elem}").text() is "0" then foundOne = false
      if foundOne
        nerdamer(d).text "fractions"
      else
        findC a, b, maxN

    x = switch level
      when 1 then "x"
      else rnd.letter()
    maxN = 9
    [a, b, c] = (
      for i in [1..3]
        [n, d] = rnd.uniqueInts2Plus maxN
        nerdamer("#{n}/#{d}").text "fractions"
    )
    d = findD b, c, maxN
    op1 = rnd.opStrich()
    op2 = rnd.opStrich()
    op3 = rnd.opStrich()
    head = rnd.bool()
    leftSide = "(#{a} #{x}#{op1}#{b})^2"
    rightSide = "(#{a} #{x}#{op2}#{c})*(#{a} #{x}#{op3}#{d})"
    if head then [leftSide, rightSide] = [rightSide, leftSide]
    problem = "#{leftSide}=#{rightSide}"
    #nerdamer wants the polynomials expanded
    leftPoly = nerdamer("expand(#{leftSide})").text()
    rightPoly = nerdamer("expand(#{rightSide})").text()
    polyProblem = "#{leftPoly}=#{rightPoly}"
    #return
    problem : problem
    solution : "#{x}=" + nerdamer.solveEquations(polyProblem, x).toString()
    description : switch language
      when "de" then "Löse die Gleichung für #{x}:"
      else "Solve the equation for #{x}:"

exports.linearEquations =
  lineareGleichung1 :
    title :
      de : "Lineare Gleichungen 1"
      en : "Linear Equations 1"
    description :
      de : "Einfache Lineare Gleichungen"
      en : "Simple Linear Equations"
    problems : [
      levels : [1..2]
      generator : linearEquationGenerator.linGl1
    ,
      levels : [1..2]
      generator : linearEquationGenerator.linGl2
    ,
      levels : [2..3]
      levelOffset : -1
      generator : linearEquationGenerator.linGl3
    ,
      levels : [3..6]
      levelOffset : -2
      generator : linearEquationGenerator.linGl4
    ,
      levels : [4..6]
      levelOffset : -3
      generator : linearEquationGenerator.linGl5
    ,
      levels : [5..6]
      levelOffset : -4
      generator : linearEquationGenerator.linGl6
    ,
      levels : [5..6]
      levelOffset : -4
      generator : linearEquationGenerator.linGl7
    ]
  lineareGleichung2 :
    title :
      de : "Lineare Gleichungen 2"
      en : "Linear Equations 2"
    description :
      de : "Quadratische Gleichungen, bei denen der \
      Quadratische Term wegfällt"
      en : "Quadratic Equations that really turn out to \
        be linear."
    problems : [
      levels : [1..2]
      generator : linearEquationGenerator.linGl8
    ,
      levels : [2..3]
      levelOffset : -1
      generator : linearEquationGenerator.linGl9
    ]
