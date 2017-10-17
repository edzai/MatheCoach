{ Rnd } = require "../randomGenerators.coffee"
rnd = new Rnd()

{ Check } = require "../checks.coffee"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

math = require "mathjs"

exports.integrationGenerator = integrationGenerator =
  polynomial : (level = 1, language="de") ->
    problem = ""
    for i in [level+1..0]
      [a] = rnd.intsPlus(9)
      problem += "+#{a}x^#{i}"
    solution = nerdamer("integrate(#{problem}, x)")
    #return
    problem : problem
    problemTeX : nerdamer(problem).toTeX() #for poly sorting
    solution : solution.text "factions"
    solutionTeX : solution.toTeX() #for poly sorting
    description : "Berechne das Integral des Terms"

exports.integration =
  title :
    de : "Integralrechnung"
  description :
    de : "Aufleiten von Funktionen"
  problems : [
    levels : [1..5]
    generator : integrationGenerator.polynomial
  ]
