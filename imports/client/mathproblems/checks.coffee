_ = require "lodash"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

math = require "mathjs"

isEquivalent = (a, b) ->
  expand = (str) -> nerdamer("expand(#{str})").text "fractions"
  nerdamer("(#{expand a}) - (#{expand b})").text() is "0"

getPrecision = (x) ->
  for i in [1..100]
    if Number(x.toPrecision()) is Number(x.toPrecision(i))
      return i

isRounded = (roundedNum, preciseNum, minPrecision = 1) ->
  maxPrecision = getPrecision preciseNum
  for i in [minPrecision..maxPrecision]
    if Number(roundedNum.toPrecision()) is Number(preciseNum.toPrecision(i))
      return true
  false

sortSum = (str) ->
  result = str.split("")
  .map (c) ->
    switch c
      when " " then ""
      when "-" then "+-"
      when "*" then ""
      else c
  .join("")
  .split "+"
  .sort()
  .join("+")
  if result[0] is "+" then result = result[1..]
  result

noReducableFractions = (answer, solution) ->
  fractionRe = /(\d+)\s?\*?\s?[a-z]*\s?\/\s?(\d+)\s?\*?\s?[a-z]*/g
  reducableFractions = false
  while result = fractionRe.exec answer
    [fraction, numeratorStr, denominatorStr] = result
    numerator = Number(numeratorStr)
    denominator = Number(denominatorStr)
    unless math.gcd(numerator, denominator) is 1
      reducableFractions = true
  not reducableFractions

exports.Check =
  leftSideExactFit :
    pass :
      (answerRight, solutionRight, answerLeft, solutionLeft) ->
        answerLeft is solutionLeft
    required : true
    failText : "Die linke Seite der Gleichung deiner Lösung muss mit der \
      linken Seite der Gleichung der Musterlösung exakt übereinstimmen."

  leftSideOptionalExactFit :
    pass :
      (answerRight, solutionRight, answerLeft, solutionLeft) ->
        console.log "leftSideOptionalExactFit", answerLeft, solutionLeft
        if answerLeft = undefined then true
        else unless answerLeft is solutionLeft then false
    required : true
    failText : "Wenn du deine Lösung als Gleichung schreibst, \
      muss die linke Seite mit der Lösung übereinstimmen."

  exactFit :
    pass : (answer, solution) -> answer is solution
    required : true
    failText : "Das Ergebnis muss bei dieser Aufgabe \
      exakt mit der Lösung übereinstimmen."

  equivalent :
    pass : (answer, solution) ->
      answer isnt "" and
      isEquivalent answer, solution
    required : true
    passText : "Das Ergebnis ist zur Lösung äquivalent."
    failText : "Das Ergebnis ist nicht zur Lösung äquivalent."

  noReducableFractionsOptional :
    pass : noReducableFractions
    required : false
    passText : undefined
    failText : "Da kann man noch was kürzen."

  noReducableFractionsRequired :
    pass : noReducableFractions
    required : true
    passText : undefined
    failText : "Der Bruch wurde nicht vollständig gekürzt."

  summandsEquivalent :
    pass : (answer, solution) ->
      sortSum(answer) is sortSum solution
    required : true
    passText : undefined
    failText : "Der Term ist nicht vereinfacht."

  isWholePositiveNumber :
    pass : (answer, solution) ->
      re = /^\+?\s?\d+\s?$/g
      re.test answer
    required : true
    failText : "Das Ergebnis muss eine positive ganze Zahl sein."

  isWholeNumber :
    pass : (answer, solution) ->
      re = /^[+-]?\s?\d+\s?$/g
      re.test answer
    required : true
    failText : "Das Ergebnis uss eine ganze Zahl sein."

  isSingleFraction :
    pass : (answer, solution) ->
      re = ///
        (^
          [-]?\s?\d+\s?\*?\s?[a-z]*\s?
          \/
          \s?\d+\s?\*?\s?[a-z]*
        $)|(^
          [-]?\d+
        $)
      ///
      re.test answer
    required : true
    passText : undefined
    failText : "Das Ergebnis muss ein einzelner Bruch \
      oder eine einzelne ganze Zahl sein."

  isSinglePower :
    pass : (answer, solution) ->
      re = ///
        ^(
          ([-]?\d+)
          |
          (
            [-]?
            ((\d+)|(\d?\s?\w+))
            \^
            (
              ([-]?\d+)
              |
              ([-]?\([^\(\)]+\))
            )
          )
        )$
      ///
      re.test answer
    required : true
    passText : undefined
    failText :
      "Das Ergebnis muss eine einzelne Potenz oder eine einzelne Zahl sein."

  firstFactorEquivalent :
    pass : (answer, solution) ->
      getFirstFactor = (str) ->
        ///
          ^
          (
            \d*
            (?:
              (?:\*\w+)
            |
              (?:\w*)
            )
          )
          (?:
            \s*\**\(
          )
        ///.exec(str)?[1]
      answerFactor = getFirstFactor answer
      solutionFactor = getFirstFactor solution
      answerFactor? and solutionFactor? and
        answerFactor isnt "" and
        solutionFactor isnt "" and
        isEquivalent answerFactor, solutionFactor
    required : true
    passText : undefined
    failText :
      "Der auszuklammernde Faktor steht nicht vor der Klammer"

  scheitelpunktForm :
    pass : (answer, solution) ->
      ///
        ^
        (([+-]?\d+\*?)|\-)?
        \(x
        ([+-]\d+)?
        \)\^2
        ([+-]\d+)?
        $
      ///.test answer
    required : true
    passText : "Die Form des Ergebnisses entspricht der Scheitelpunktform"
    failText :
      "Das Ergebnis hat nicht die korrekte Scheitelpunktform"

  roundedValue : (decimals) ->
    pass : (answer, solution) ->
      if decimals?
        minPrecision = getPrecision math.round(Number(solution), decimals)
      isRounded Number(answer), Number(solution), minPrecision
    required : true
    failText : "Das Ergebnis entspricht nicht der Lösung"

  roundedValueWithUnit : (decimals, unit) ->
    pass : (answer, solution) ->
      try
        answerUnit = math.unit answer
        solutionUnit = math.unit solution
        unit ?= solutionUnit.toJSON().unit
        answerNumber = answerUnit.toNumber unit
        solutionNumber = solutionUnit.toNumber unit
        if decimals? and unit?
          roundedSolution =
            math.chain solutionUnit
            .toNumber unit
            .round decimals
            .done()
          minPrecision = getPrecision roundedSolution
        isRounded answerNumber, solutionNumber, minPrecision
      catch error
        console.log error
        false

    required : true
    failText : "Das Ergebnis entspricht nicht der Lösung."


  equivalentWithUnit :
    pass : (answer, solution) ->
      try
        fixedAnswer = answer.replace /\*10\^/g, "e"
        math.unit(fixedAnswer).equals math.unit(solution)
      catch error
        console.log error
        false

    required : true
    passText : "Das Ergebnis ist zur Lösung äquivalent."
    failText : "Das Ergebnis ist nicht zur Lösung äquivalent."

  isSingleValueWithUnit :
    pass : (answer, solution) ->
      try
        fixedAnswer = answer.replace /\*10\^/g, "e"
        math.unit(fixedAnswer)?
      catch error
        console.log error
        false
    required : true
    failText : "Das Ergebnis muss ein einzelner Zahlenwert mit Einheit sein."

  #schlägt nicht an, wenn isSingleValueWithUnit fehler meldet
  unitIs : (unit) ->
    pass : (answer, solution) ->
      try
        fixedAnswer = answer.replace /\*10\^/g, "e"
        math.unit(fixedAnswer).toJSON().unit is unit
      catch error
        console.log error
        true
    required : true
    failText : "Die geforderte Einheit #{unit} wurde nicht benutzt."

  answerEndsWith : (str) ->
    pass : (answer, solution) ->
      ///
        #{str}
        $
      ///.test answer
    required : true
    failText : "Am Ende des Ergebnisses muss '#{str}' stehen."

  noPowerOfBracket :
    pass : (answer, solution) -> not /\)\^/.test answer
    required : true
    failText : "Das Ergebnis enthält die Potenz eines Klammertermes."
