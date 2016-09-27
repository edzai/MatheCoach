{ Rnd } = require "./randomGenerators.coffee"
rnd = new Rnd()

{ re } = require "./RegExs.coffee"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

{ fractionGenerator } =
  require "./problemGenerators/fractions.coffee"
{ linearEquationGenerator } =
  require "./problemGenerators/linearEquations.coffee"
{ powersGenerator } =
  require "./problemGenerators/powers.coffee"
{ expressionGenerator } =
  require "./problemGenerators/expressions.coffee"
{ einXeinsGenerator } =
  require "./problemGenerators/einXeins.coffee"
{ polynomialDivisionGenerator } =
  require "./problemGenerators/polynomialDivision.coffee"
{ quadraticEquationGenerator } =
  require "./problemGenerators/quadraticEquations.coffee"
{ nullStellenGenerator } =
  require "./problemGenerators/nullstellen.coffee"
#math = require "mathjs"


exports.modules = [
  "einXeins"
  "bruch1"
  "bruch2"
  "bruch3"
  "bruch4"
  "terme1"
  "potenz1"
  "lineareGleichung1"
  "lineareGleichung2"
  "quadratischeGleichung"
  "nullStellen"
  "polynomialDivision"
]

exports.problemDefinitions =
  einXeins :
    title : "1 x 1"
    description : "Multiplikation und Division mit Ganzen Zahlen"
    problems : [
      levels : [1..5]
      generator : einXeinsGenerator.multiplikation
    ,
      levels : [3..5]
      levelOffset : -2
      generator : einXeinsGenerator.division
    ]
  bruch1 :
    title : "Bruchrechnen 1"
    description : "Addition und Subtraktion von Brüchen"
    problems : [
      levels : [1..2]
      generator : fractionGenerator.strichGleichnamig
    ,
      levels : [2..4]
      levelOffset : -1
      generator : fractionGenerator.strichUngleichnamig
    ]
  bruch2 :
    title : "Bruchrechnen 2"
    description : "Multiplikation von Brüchen"
    problems : [
      levels : [1..2]
      generator : fractionGenerator.malGanzeZahl
    ,
      levels : [1..3]
      generator : fractionGenerator.malBruchKuerzbar
    ,
      levels : [2..3]
      generator : fractionGenerator.malKreuzKuerzbar
    ]
  bruch3 :
    title : "Bruchrechnen 3"
    description : "Division mit Brüchen"
    problems : [
      levels : [1..2]
      generator : fractionGenerator.bruchDurchZahl
    ,
      levels : [2..3]
      levelOffset : -1
      generator : fractionGenerator.bruchDurchZahl2
    ,
      levels : [2..4]
      levelOffset : -1
      generator : fractionGenerator.bruchDurchBruch
  ]
  bruch4 :
    title : "Bruchrechnen"
    description : "Vermischte Aufgaben zur Bruchrechnung"
    problems : [
      levels : [1..2]
      generator : fractionGenerator.strichGleichnamig
    ,
      levels : [1..3]
      generator : fractionGenerator.strichUngleichnamig
    ,
      levels : [1..2]
      generator : fractionGenerator.malGanzeZahl
    ,
      levels : [1..3]
      generator : fractionGenerator.malBruch
    ,
      levels : [2..4]
      levelOffset : -1
      generator : fractionGenerator.bruchDurchBruch
    ,
      levels : [4..5]
      levelOffset : -3
      generator : fractionGenerator.zusammenGesetzt
    ]
  terme1 :
    title : "Terme vereinfachen"
    description : "Terme zusammenfassen, Ausklammern und Ausmultiplizieren"
    problems : [
      levels : [1..3]
      generator : expressionGenerator.summeZusFass
    ,
      levels : [2..3]
      levelOffset : -1
      generator : expressionGenerator.summeZusFassExp
    ,
      levels : [3..5]
      levelOffset : -2
      generator : expressionGenerator.expandKlammer
    ,
      levels : [4..5]
      levelOffset : -3
      generator : expressionGenerator.expandKlammerKlammer
    ]
  lineareGleichung1 :
    title : "Lineare Gleichungen 1"
    description : "Einfache Lineare Gleichungen"
    problems : [
      levels : [1..2]
      generator : linearEquationGenerator.linGl1
    ,
      levels : [1..2]
      generator : linearEquationGenerator.linGl2
    ,
      levels : [2..3]
      levelOffset : -1
      generator : linearEquationGenerator.linGl3
    ,
      levels : [3..6]
      levelOffset : -2
      generator : linearEquationGenerator.linGl4
    ,
      levels : [4..6]
      levelOffset : -3
      generator : linearEquationGenerator.linGl5
    ,
      levels : [5..6]
      levelOffset : -4
      generator : linearEquationGenerator.linGl6
    ,
      levels : [5..6]
      levelOffset : -4
      generator : linearEquationGenerator.linGl7
    ]
  lineareGleichung2 :
    title : "Lineare Gleichungen 2"
    description : "Quadratische Gleichungen, bei denen der \
      Quadratische Term wegfällt"
    problems : [
      levels : [1..2]
      generator : linearEquationGenerator.linGl8
    ,
      levels : [2..3]
      levelOffset : -1
      generator : linearEquationGenerator.linGl9
    ]
  quadratischeGleichung :
    title : "Quadratische Gleichungen"
    description : "Einfache Quadratische Gleichungen Lösen (z.B. mit der pq-Formel)"
    problems : [
      levels : [1..5]
      generator : quadraticEquationGenerator.intsOnly
    ]
  potenz1 :
    title : "Potenzen und Wurzeln 1"
    description : "Aufgaben zum 1. Potenzgesetz"
    problems : [
      levels : [1..3]
      generator : powersGenerator.exp1Num
    ,
      levels : [2..4]
      levelOffset : -1
      generator : powersGenerator.exp1Var
    ,
      levels : [3..5]
      levelOffset : -2
      generator : powersGenerator.exp1NumQuotient
    ,
      levels : [4]
      generator : powersGenerator.sqrtAsPower
    ,
      levels : [4..5]
      generator : powersGenerator.sqrt1Num
    ]
  nullStellen :
    title : "Nullstellen Ganzrationaler Funktionen"
    description : "pq-Formel, Substitution und teilweise factorisierte Polynome."
    problems : [
      levels : [1..4]
      generator : nullStellenGenerator.pq
    ,
      levels : [2..5]
      levelOffset : -1
      generator : nullStellenGenerator.substitution
    ,
      levels : [3..5]
      levelOffset : -2
      generator : nullStellenGenerator.factorized
    ]
  polynomialDivision :
    title : "Polynomdivision"
    description : "Nicht so schlimm, wie es zunächst aussieht."
    problems : [
      levels : [1..5]
      generator : polynomialDivisionGenerator.division
    ]
  test :
    title : "Test"
    description : "Testbereich für den Aufgabengenerator, \
      an dem ich gerade rumprogrammiere"
    problems : [
      levels : [1..5]
      generator : nullStellenGenerator.test
    ]
