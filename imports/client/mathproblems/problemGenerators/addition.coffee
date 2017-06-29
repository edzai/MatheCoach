{ Rnd } = require "../randomGenerators.coffee"
rnd = new Rnd()

{ Check } = require "../checks.coffee"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

math = require "mathjs"

{ teXifyAM } = require "../renderAM.coffee"

checksPositive = [Check.equivalent, Check.isWholePositiveNumber]
checks = [Check.equivalent, Check.isWholeNumber]

getNumbers = (level) ->
  switch level
    when 1
      rnd.intsPlus 9
    when 2
      rnd.intsPlus 19
    when 3
      rnd.intsPlus 59
    when 4
      rnd.intsPlus 99
    when 5
      rnd.intsPlus 999
    else
      rnd.intsPlus 9999

exports.strichrechnungGenerator = generator =
  additionNatural : (level = 1) ->
    [a,b] = getNumbers level
    #return
    problem : "#{a}+#{b}"
    description : "Addiere die zwei Ganzen Zahlen:"
    checks : checksPositive
  subtraktionNatural : (level = 1) ->
    [a,b] = getNumbers level
    if b > a then [a, b] = [b, a]
    #return
    problem : "#{a}-#{b}"
    description : "Subtrahiere die zwei Ganzen Zahlen:"
    checks : checksPositive
  strichGanzzahlig : (level = 1) ->
    [a, b] = getNumbers level
    [op1, op2, op3] = rnd.opsStrich()
    problem = "(#{op1}#{a})#{op2}(#{op3}#{b})"
    #return
    problem : problem
    problemTeX : problem
    description : "Berechne:"
    checks : checks

exports.strichrechnungGanzzahlig =
  title : "Strichrechnung mit Natürlichen Zahlen"
  description : "Plus und Minus ohne Komma"
  problems : [
    levels : [1..7]
    generator : generator.additionNatural
  ,
    levels : [2..7]
    levelOffset : -1
    generator : generator.subtraktionNatural
  ]

exports.strichrechnungRational =
  title : "Strichrechung mit Rationalen Zahlen"
  description : "Plus und Minus mit (möglicherweise) negativem Ergebnis"
  problems : [
    levels : [1..6]
    generator : generator.strichGanzzahlig
  ]
