{ Rnd } = require "../randomGenerators.coffee"
rnd = new Rnd()

{ Check } = require "../checks.coffee"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

math = require "mathjs"

#nerdamer doesn't have working integration atm
#so we have to do things backwards
#the integration constant makes things messy

exports.integrationGenerator = integrationGenerator =
  polynomial : (level = 1) ->
    solution = ""
    constant = 1
    for n, i in rnd.intsPlus(9)[1..level+1]
      unless i is 0 then solution += "*"
      constant *= n
      solution += "(x+#{n})"
    solution = solution + "-#{constant}"
    expandedSolution = nerdamer("expand(#{solution})").text "fractions"
    problem = nerdamer("diff(#{expandedSolution}, x)").text "fractions"
    #return
    problem : problem
    problemTeX : nerdamer(problem).toTeX() #for poly sorting
    solution : expandedSolution
    solutionTeX : nerdamer(expandedSolution).toTeX()
    description : "Berechne das Integral des Terms"

exports.integration =
  title : "Integralrechnung"
  description : "Aufleiten von Funktionen"
  problems : [
    levels : [1..5]
    generator : integrationGenerator.polynomial
  ]
