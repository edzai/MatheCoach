{ Rnd } = require "../randomGenerators.coffee"
rnd = new Rnd()

{ Check } = require "../checks.coffee"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

math = require "mathjs"

exports.differentiationGenerator = differentiationGenerator =
  polynomial : (level = 1, language="de") ->
    problem = ""
    for i in [level+1..0]
      [a] = rnd.intsPlus(9)
      problem += "+#{a}x^#{i}"
    solution = nerdamer("diff(#{problem}, x)")
    #return
    problem : problem
    problemTeX : nerdamer(problem).toTeX() #get rid of superfluous + and x^0
    solution : solution.text "factions"
    solutionTeX : solution.toTeX() #ditto
    description : "Berechne die Ableitung des Terms"

exports.differentiation =
  title :
    de : "Differentialrechnung"
  description :
    de : "Ableitung von Funktionen"
  problems : [
    levels : [1..5]
    generator : differentiationGenerator.polynomial
  ]
