{ Rnd } = require "../randomGenerators.coffee"
rnd = new Rnd()

{ Check } = require "../checks.coffee"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

math = require "mathjs"

exports.differentiationGenerator = differentiationGenerator =
  polynomial : (level = 1) ->
    problem = ""
    for i in [level+1..0]
      [a] = rnd.intsPlus(9)
      problem += "+#{a}x^#{i}"
    solution = nerdamer("diff(#{problem}, x)").text "factions"
    solutionExpanded = nerdamer("expand(#{solution})")
    #return
    problem : problem
    problemTeX : nerdamer(problem).toTeX() #for poly sorting
    solution : solutionExpanded.text "fractions"
    solutionTeX : solutionExpanded.toTeX() #for poly sorting
    description : "Berechne die Ableitung des Terms"

exports.differentiation =
  title : "Differentialrechnung"
  description : "Ableitung von Funktionen"
  problems : [
    levels : [1..5]
    generator : differentiationGenerator.polynomial
  ]
