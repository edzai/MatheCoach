{ Rnd } = require "../randomGenerators.coffee"
rnd = new Rnd()

{ Check } = require "../checks.coffee"

# nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
# require "/imports/modules/nerdamer/Solve.js"

math = require "mathjs"

exports.unitsGenerator = generator =
  transformUnit : (unitNamesGenerator) ->
    (level = 1, language="de") ->
      math.config
        number : "BigNumber"
        precision : 8
      [enu, deno] = switch level
        when 1 then [99, 1]
        else
          [999, 10]
      [problemUnit, solutionUnit] = unitNamesGenerator()
      problemNumber = math.eval("(#{rnd.intPlus enu}/#{deno})")
      problem = "#{problemNumber} #{problemUnit}"
      solution = math.unit(problem).to(solutionUnit).toString()
      #returns
      problem : "not Used"
      problemTeX : "\\text{Wandle }#{problem}\\text{ um in }#{solutionUnit}"
      description : switch language
        when "de"
          "Rechne die Einheiten um:"
        else
          "Convert the units:"
      solution : solution
      answerPreprocessor : (answer) -> answer
      checks : [
        Check.isSingleValueWithUnit
        Check.equivalentWithUnit
        Check.unitIs(solutionUnit)
      ]

  addUnit : (unitNamesGenerator) ->
    (level = 1, language="de") ->
      math.config
        number : "BigNumber"
        precision : 64
      [enu, deno] = switch level
        when 1 then [99, 1]
        else
          [999, 10]
      unitNames = unitNamesGenerator()
      [a,b] =
        rnd.intsPlus(enu)[0..1].map (n, i) ->
          math.eval("(#{n}/#{deno}) #{unitNames[i]}")
      solution = math.eval("a+b",{a,b}).toString()
      #returns
      problem : "not Used"
      problemTeX : "#{a} + #{b}"
      description : switch language
        when "de"
          "Berechne die Summe. Wähle eine passende Einheit."
        else
          "Calculate the sum. Choose an appropriate unit of measurement."
      solution : solution
      answerPreprocessor : (answer) -> answer
      checks : [Check.isSingleValueWithUnit, Check.equivalentWithUnit]
  multiplyUnit : (unitNamesGenerator) ->
    (level = 1, language="de") ->
      math.config
        number : "BigNumber"
        precision : 64
      [enu, deno] = switch level
        when 1 then [99, 1]
        else
          [999, 10]
      unitNames = unitNamesGenerator()
      [a,b] =
        rnd.intsPlus(enu)[0..1].map (n, i) ->
          math.eval("(#{n}/#{deno}) #{unitNames[i]}")
      solution = math.eval("a*b",{a,b}).toString()
      #returns
      problem : "not Used"
      problemTeX : "#{a} \\times #{b}"
      description : switch language
        when "de"
          "Berechne das Produkt. Wähle eine passende Einheit."
        else
          "Calculate the product. Choose an appropriate unit of measurement."
      solution : solution
      answerPreprocessor : (answer) -> answer
      checks : [Check.isSingleValueWithUnit, Check.equivalentWithUnit]

exports.units =
  length :
    title :
      de : "Länge"
      en : "Distance"
    description :
      de : "Umrechnen von Längeneinheite. Summe von Längen."
      en : "Conversion of Units of Measurement. Sums of Distances."
    problems : [
      levels : [1..2]
      generator : generator.transformUnit rnd.uniqueLengthUnits
    ,
      levels : [2..3]
      levelOffset : -1
      generator : generator.addUnit rnd.uniqueLengthUnits
    ]
  area :
    title :
      de : "Fläche"
      en : "Area"
    description :
      de : "Umrechnen von Flächeneinheiten. Produkte von Längen."
      en : "Conversion of Units of Measurement. Products of Distances"
    problems : [
      levels : [1..2]
      generator : generator.transformUnit rnd.uniqueAreaUnits
    ,
      levels : [2..3]
      levelOffset : -1
      generator : generator.multiplyUnit rnd.uniqueLengthUnits
    ]
  volume :
    title :
      de : "Volumen"
      en : "Volume"
    description :
      de : "Umrechnen von Volumeneinheiten."
      en : "Conversion of Units of Measurement."
    problems : [
      levels : [1..2]
      generator : generator.transformUnit rnd.uniqueVolumeUnits
    ]
  mix :
    title :
      de : "Länge, Fläche und Volumen"
      en : "Distance, Area and Volume"
    description :
      de : "Vermischete Aufgben"
      en : "Assorted Problems"
    problems : [
      levels : [1..2]
      generator : generator.transformUnit rnd.uniqueLengthUnits
    ,
      levels : [2..3]
      levelOffset : -1
      generator : generator.addUnit rnd.uniqueLengthUnits
    ,
      levels : [1..2]
      generator : generator.transformUnit rnd.uniqueAreaUnits
    ,
      levels : [1..2]
      generator : generator.multiplyUnit rnd.uniqueLengthUnits
    ,
      levels : [1..2]
      generator : generator.transformUnit rnd.uniqueVolumeUnits
    ]
