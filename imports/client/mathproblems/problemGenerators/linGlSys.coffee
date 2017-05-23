{ Rnd } = require "../randomGenerators.coffee"
rnd = new Rnd()

{ Check } = require "../checks.coffee"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

generators =
  linGlSys : (level = 1) ->
    #return
    problem : "a=1, b=a+1, c=a+2"
    solution : "a=1, b=2, c=3"
    description : "Löse das Lineare Gleichungssystem. Bestimme a, b und c"
    checks : [
      Check.equivalent
      Check.noReducableFractionsOptional,
      Check.leftSideExactFit
    ]
exports.linGlSys =
  title : "Lineare Gleichungssysteme"
  description : "Mehrere Gleichungen mit mehreren Unbekannten"
  problems : [
    levels : [1]
    generator : generators.linGlSys
  ]
