_ = require "lodash"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

math = require "mathjs"

isEquivalent = (a, b) ->
  expand = (str) -> nerdamer("expand(#{str})").text "fractions"
  nerdamer("(#{expand a}) - (#{expand b})").text() is "0"

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
    failText : "Der Term ist nicht richtig vereinfacht."

  isWholePositiveNumber :
    pass : (answer, solution) ->
      re = /^\+?\s?\d+\s?$/g
      re.test answer
    required : true
    failText : "Das Ergebnis muss eine positive ganze Zahl sein."

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
