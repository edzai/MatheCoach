{ Rnd } = require "../randomGenerators.coffee"
rnd = new Rnd()

{ Check } = require "../checks.coffee"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

math = require "mathjs"

exports.differentiationGenerator = differentiationGenerator =
  polynomial : (level = 1) ->
    problem = ""
    for n, i in rnd.intsPlus(9)[1..level]
      unless i is 0 then problem += "*"
      problem += "(x+#{n})"
    #return
    problem : problem
    problemTeX : nerdamer("expand(#{problem})").toTeX() #for poly sorting
    solution : nerdamer("diff(#{problem}, x)").text "factions"
    description : "Berechne die Ableitung des Terms"

exports.differentiation =
  title : "Differentialrechnung"
  description : "Ableitung von Funktionen"
  problems : [
    levels : [1..5]
    generator : differentiationGenerator.polynomial
  ]
