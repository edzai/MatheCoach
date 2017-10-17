{ Rnd } = require "../randomGenerators.coffee"
rnd = new Rnd()

{ Check } = require "../checks.coffee"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

math = require "mathjs"

{ teXifyAM } = require "../renderAM.coffee"

exports.prismenGenerator = generator =
  cylinderVolume : (level = 1, language="de") ->
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

  cylinderSurface : (level = 1, language="de") ->
    unit = rnd.lengthUnit()
    [r, h] = rnd.ints2Plus(150).map (i) -> math.unit i, unit
    scope = {r,h}
    math.eval "d=2*r", scope
    rString = if rnd.bool()
      "Radius r = #{scope.r}"
    else
      "Durchmesser d = #{scope.d}"
    surface = math.eval "2*pi*r^2+2*pi*r*h", scope
    skipExpression : true
    problem : "not used"
    solution : surface.toString()
    description : "Berechne die Oberfläche eines Zylinders \
      mit #{rString} und Höhe h = #{h}."
    hint : "Du kannst das Ergebnis runden, aber vergiss die Einheit nicht."
    checks : [Check.roundedValueWithUnit()]
    answerPreprocessor : (answer) -> answer

  cuboidVolume : (level = 1, language="de") ->
    unit = rnd.lengthUnit()
    [l, b, h] = rnd.ints2Plus(150).map (i) -> math.unit i, unit
    scope = {l, b, h}
    volume = math.eval "l*b*h", scope
    skipExpression : true
    problem : "not used"
    solution : volume.toString()
    description : "Berechne das Volumen eines Quaders \
      mit Länge l = #{l}, Breite b = #{b} und Höhe h = #{h}."
    hint : "Du kannst das Ergebnis runden, aber vergiss die Einheit nicht."
    checks : [Check.roundedValueWithUnit()]
    answerPreprocessor : (answer) -> answer

  cuboidSurface : (level = 1, language="de") ->
    unit = rnd.lengthUnit()
    [l, b, h] = rnd.ints2Plus(150).map (i) -> math.unit i, unit
    scope = {l, b, h}
    surface = math.eval "2*(l*b+l*h+b*h)", scope
    skipExpression : true
    problem : "not used"
    solution : surface.toString()
    description : "Berechne die Oberfläche eines Quaders \
      mit Länge l = #{l}, Breite b = #{b} und Höhe h = #{h}."
    hint : "Du kannst das Ergebnis runden, aber vergiss die Einheit nicht."
    checks : [Check.roundedValueWithUnit()]
    answerPreprocessor : (answer) -> answer


exports.prismen =
  title :
    de : "Prismen"
  description :
    de : "Volumen und Oberfläche von Prismen"
  problems : [
    levels: [1]
    generator : generator.cuboidVolume
  ,
    levels : [1]
    generator : generator.cuboidSurface
  ,
    levels : [1]
    generator : generator.cylinderVolume
  ,
    levels : [1]
    generator : generator.cylinderSurface
  ]
