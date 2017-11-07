{ Rnd } = require "../randomGenerators.coffee"
rnd = new Rnd()

{ Check } = require "../checks.coffee"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

math = require "mathjs"

{ teXifyAM } = require "../renderAM.coffee"

#TODO: Fix exception thrown by mathjs, bickering about not being able to implicitly convert to bignumber

exports.prismenGenerator = generator =
  cylinderVolume : (level = 1, language="de") ->
    unit = rnd.lengthUnit()
    [r, h] = rnd.ints2Plus(150).map (i) -> math.unit i, unit
    scope = {r,h}
    math.eval "d=2*r", scope
    rString =if rnd.bool()
      switch language
        when "de" then "Radius r = #{scope.r}"
        else "radius r = #{scope.r}"
    else
      switch language
        when "de" then "Durchmesser d = #{scope.d}"
        else "diameter d = #{scope.d}"
    volume = math.eval "pi * r^2 * h", scope
    # roundedVolumeNumber =
    #   math.round volume.toNumber("#{unit}^3"), 1
    skipExpression : true
    problem : "not used"
    solution : volume.toString() #"#{roundedVolumeNumber} #{unit}^3"
    description : switch language
      when "de"
        "Berechne das Volumen eines Zylinders \
        mit #{rString} und Höhe h = #{h}."
      else
        "Calculate the volume of a cylinder with #{rString} and \
        height h = #{{h}}."
    hint : switch language
      when "de"
        "Du kannst das Ergebnis runden, aber vergiss die Einheit nicht."
      else
        "You may round the result. Don't forget to include the \
        unit of measurement."
    checks : [Check.roundedValueWithUnit()]
    answerPreprocessor : (answer) -> answer

  cylinderSurface : (level = 1, language="de") ->
    unit = rnd.lengthUnit()
    [r, h] = rnd.ints2Plus(150).map (i) -> math.unit i, unit
    scope = {r,h}
    math.eval "d=2*r", scope
    rString = if rnd.bool()
      switch language
        when "de" then "Radius r = #{scope.r}"
        else "radius r = #{scope.r}"
    else
      switch language
        when "de" then "Durchmesser d = #{scope.d}"
        else "diameter d = #{scope.d}"
    surface = math.eval "2*pi*r^2+2*pi*r*h", scope
    skipExpression : true
    problem : "not used"
    solution : surface.toString()
    description : switch language
      when "de"
        "Berechne die Oberfläche eines Zylinders \
        mit #{rString} und Höhe h = #{h}."
      else
        "Calculate the surface area of a cylinder with #{rString} and \
        height h = #{{h}}."
    hint : switch language
      when "de"
        "Du kannst das Ergebnis runden, aber vergiss die Einheit nicht."
      else
        "You may round the result. Don't forget to include the \
        unit of measurement."
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
    description : switch language
      when "de"
        "Berechne das Volumen eines Quaders \
        mit Länge l = #{l}, Breite b = #{b} und Höhe h = #{h}."
      else
        "Calculate the volume of a cuboid with length l = #{l}, \
        width w= #{b} and height h = #{h}."
    hint : switch language
      when "de"
        "Du kannst das Ergebnis runden, aber vergiss die Einheit nicht."
      else
        "You may round the result. Don't forget to include the \
        unit of measurement."
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
    description : switch language
      when "de"
        "Berechne die Oberfläche eines Quaders \
        mit Länge l = #{l}, Breite b = #{b} und Höhe h = #{h}."
      else
        "Calculate the surface area of a cuboid with length l = #{l}, \
        width w= #{b} and height h = #{h}."
    hint : switch language
      when "de"
        "Du kannst das Ergebnis runden, aber vergiss die Einheit nicht."
      else
        "You may round the result. Don't forget to include the \
        unit of measurement."
    checks : [Check.roundedValueWithUnit()]
    answerPreprocessor : (answer) -> answer


exports.prismen =
  title :
    de : "Prismen"
    en : "Prisms and Cylinders"
  description :
    de : "Volumen und Oberfläche von Prismen"
    en : "Volume and Surface Area"
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
