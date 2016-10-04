_ = require "lodash"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

math = require "mathjs"


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
  equivalent :
    pass : (answer, solution) ->
      answer isnt "" and
      nerdamer("(#{answer}) - (#{solution})").text() is "0"
    required : true
    passText : "Das Ergebnis ist zur Lösung equivalent."
    failText : "Das Ergebnis is nicht zur Lösung equivalent."

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
    failText : "Der Term ist nicht richtig Vereinfacht."

  isWholePositiveNumber :
    pass : (answer, solution) ->
      re = /^\+?\s?\d+\s?$/g
      re.test answer
    required : true
    failText : "Das Ergebnis muss eine positive Ganze Zahl sein."

  isSingleFraction :
    pass : (answer, solution) ->
      re = ///
        (
          ^
          [-]?\s?\d+\s?\*?\s?[a-z]*\s?
          \/
          \s?\d+\s?\*?\s?[a-z]*
          $
        )
        |
        (
          ^
          [-]?\d+
          $
        )
      ///
      re.test answer
    required : true
    passText : undefined
    failText : "Das Ergebnis muss ein einzelner Bruch \
      oder eine einzelne Ganze Zahl sein."

  isSinglePower :
    pass : (answer, solution) ->
      re = ///
        ^
        (
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
        )
        $
      ///
      re.test answer
    required : true
    passText : undefined
    failText :
      "Das Ergebnis muss eine einzelne Potenz oder eine einzelne Zahl sein."
