{ Rnd } = require "../randomGenerators.coffee"
rnd = new Rnd()

{ Check } = require "../checks.coffee"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

math = require "mathjs"

{processEquation} = require "./quadraticEquations.coffee"

exports.nullStellenGenerator = nullStellenGenerator =
  pq : (level = 1, language="de") ->
    [a, b, c] = rnd.intsPlus(9)
    x = rnd.letter()
    [op1, op2, op3] = rnd.opsMinus()
    if level < 2
      x = "x"
      op1 = ""
      a = 1
    factorized = "#{op1}#{a}*(#{x}-#{op2}#{b})*(#{x}-#{op3}#{c})"
    equation = "#{factorized}=0"
    expandedTeX = nerdamer("expand(#{factorized})").toTeX()
    problemTeX = "f(#{x})=#{expandedTeX}"
    processed = processEquation equation, x
    solution = processed.solution
    #return
    problem : "not used"
    problemTeX : problemTeX
    solution : solution
    solutionTeX : "\\mathbb{L}=\\left\\{#{solution}\\right\\}"
    description : switch language
      when "de" then "Finde die Nullstellen:"
      else "Find the roots:"
    hint :
      if level < 2
        switch language
          when "de"
            "Verwende die pq-Formel"
          else
            "Use the Quadratic Formula."

  substitution : (level = 1, language="de") ->
    [a, b, c] = rnd.intsPlus(9)
    x = rnd.letter()
    [op1, op2, op3] = rnd.opsMinus()
    if level < 2
      x = "x"
      op1 = ""
      a = 1
    factorized = "#{op1}#{a}*(#{x}^2-#{b}^2)*(#{x}^2-#{c}^2)"
    equation = "#{factorized}=0"
    expandedTeX = nerdamer("expand(#{factorized})").toTeX()
    problemTeX = "f(#{x})=#{expandedTeX}"
    processed = processEquation equation, x
    solution = processed.solution
    #return
    problem : "not used"
    problemTeX : problemTeX
    solution : solution
    solutionTeX : "\\mathbb{L}=\\left\\{#{solution}\\right\\}"
    description : switch language
      when "de" then "Finde die Nullstellen:"
      else "Find the roots:"

  factorized : (level = 1, language="de") ->
    [a, b, c, d, e] = rnd.intsPlus(9)
    x = rnd.letter()
    [op1, op2, op3, op4, op5] = rnd.opsStrich()
    firstFactorized = switch level
      when 1
        "(#{x}#{op3}#{c})"
      when 2
        "(#{x}#{op2}#{b})*(#{x}#{op3}#{c})"
      else
        "#{op1}#{a}*(#{x}#{op2}#{b})*(#{x}#{op3}#{c})"
    secondFactorized = "(#{x}#{op4}#{d})*(#{x}#{op5}#{e})"
    equation = "#{firstFactorized}*#{secondFactorized}=0"
    firstExpandedTeX = nerdamer("expand(#{firstFactorized})").toTeX()
    secondExpandedTeX = nerdamer("expand(#{secondFactorized})").toTeX()
    problemTeX = "f(#{x})=(#{firstExpandedTeX})(#{secondExpandedTeX})"
    processed = processEquation equation, x
    solution = processed.solution
    #return
    problem : "not used"
    problemTeX : problemTeX
    solution : solution
    solutionTeX : "\\mathbb{L}=\\left\\{#{solution}\\right\\}"
    description : switch language
      when "de" then "Finde die Nullstellen:"
      else "Find the roots:"

exports.nullstellen =
  title :
    de : "Nullstellen Ganzrationaler Funktionen"
    en : "Roots of Polynomial Functions"
  description :
    de : "pq-Formel, Substitution und teilweise factorisierte Polynome."
    en : "Quadratic Formula, Substitution, Partially Factored Polynomials"
  problems : [
    levels : [1..4]
    generator : nullStellenGenerator.pq
  ,
    levels : [2..5]
    levelOffset : -1
    generator : nullStellenGenerator.substitution
  ,
    levels : [3..5]
    levelOffset : -2
    generator : nullStellenGenerator.factorized
  ]
