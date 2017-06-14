{ Rnd } = require "../randomGenerators.coffee"
rnd = new Rnd()

{ Check } = require "../checks.coffee"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

math = require "mathjs"

{ teXifyAM } = require "../renderAM.coffee"

exports.prismenGenerator = generator =
  cylinderVolume : (level = 1) ->
    unit = rnd.lengthUnit()
    [r, h] = rnd.ints2Plus(150).map (i) -> math.unit i, unit
    scope = {r,h}
    math.eval "d=2*r", scope
    rString = if rnd.bool()
      "Radius r = #{scope.r}"
    else
      "Durchmesser d = #{scope.d}"
    volume = math.eval "pi * r^2 * h", scope
    # roundedVolumeNumber =
    #   math.round volume.toNumber("#{unit}^3"), 1
    skipExpression : true
    problem : "not used"
    solution : volume.toString() #"#{roundedVolumeNumber} #{unit}^3"
    description : "Berechne das Volumen eines Zylinders \
      mit #{rString} und Höhe h = #{h}."
    hint : "Du kannst das Ergebnis runden, aber vergiss die Einheit nicht."
    checks : [Check.roundedValueWithUnit()]
    answerPreprocessor : (answer) -> answer

exports.prismen =
  title : "Prismen"
  description : "Volumen und Oberfläche von Prismen"
  problems : [
    levels : [1]
    generator : generator.cylinderVolume
  ]
