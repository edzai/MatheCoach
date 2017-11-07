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
    description : switch language
      when "de" then "Berechne die Ableitung des Terms"
      else "Find the derivative."

exports.differentiation =
  title :
    de : "Differentialrechnung"
    en : "Differential Calculus"
  description :
    de : "Ableitung von Funktionen"
    en : "Differentiate Functions"

  problems : [
    levels : [1..5]
    generator : differentiationGenerator.polynomial
  ]
