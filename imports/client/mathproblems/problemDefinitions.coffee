{ fractions } =
  require "./problemGenerators/fractions.coffee"
{ proportionality } =
  require "./problemGenerators/proportionality.coffee"
{ linearEquations } =
  require "./problemGenerators/linearEquations.coffee"
{ powers } =
  require "./problemGenerators/powers.coffee"
{ expressions, ausklammern } =
  require "./problemGenerators/expressions.coffee"
{ einXeins } =
  require "./problemGenerators/einXeins.coffee"
{ polynomialDivision} =
  require "./problemGenerators/polynomialDivision.coffee"
{ quadratischeGleichung } =
  require "./problemGenerators/quadraticEquations.coffee"
{ scheitelpunkt } =
  require "./problemGenerators/scheitelpunkt.coffee"
{ nullstellen } =
  require "./problemGenerators/nullstellen.coffee"
{ differentiation } =
  require "./problemGenerators/differentiation.coffee"
{ integration } =
  require "./problemGenerators/integration.coffee"
{ binomischeFormeln } =
  require "./problemGenerators/binomischeFormeln.coffee"
{ templateTest } =
  require "./problemGenerators/templateTest.coffee"
{ functionPlotTest } =
  require "./problemGenerators/functionPlotTest.coffee"
{ linearFunctions} =
  require "./problemGenerators/linearFunctions.coffee"
{ quadraticFunctions } =
  require "./problemGenerators/quadraticFunctions.coffee"
{ strahlensatz } =
  require "./problemGenerators/strahlensatz.coffee"
{ sinussatz } =
  require "./problemGenerators/sinussatz.coffee"
# { someModule } =
#   require "./problemGenerators/some.coffee"

#TODO This is Stupid, I really need to change this.
exports.modules = [
  title : "Aufgaben nach Themen"
  kindred : [
    title : "Grundrechenarten"
    description : "Die Grundlagen, die einfach sitzen müssen."
    kindred : [
      "einXeins"
      "bruch0"
      "bruch1"
      "bruch2"
      "bruch3"
      "bruch4"
      "potenz1"
      "proportionality"
    ]
  ,
    title : "Terme umformen"
    description : "Terme zusammenfassen, Umgang mit Klammern"
    kindred : [
      "terme1"
      "ausklammern"
      "binomischeFormeln"
    ]
  ,
    title : "Gleichungen"
    description : "Lineare und Quadratische Gleichungen Lösen"
    kindred : [
      "lineareGleichung1"
      "lineareGleichung2"
      "quadratischeGleichung"
    ]
  ,
    title : "Funktionen"
    description : "Funktionen, Graphen, Funktionsgleichungen"
    kindred : [
      "linearFunctions"
      "scheitelpunkt"
      "nullStellen"
    ]
  ,
    title : "Calculus"
    description : "Differential/Integralrechnung"
    kindred :[
      "differentiation"
      "integration"
    ]
  ,
    title : "Vermischtes"
    description : "Aufgaben die nicht in die anderen Kategorien passen wollen."
    kindred : [
      "polynomialDivision"
      "templateTest"
      "quadraticFunctions"
      "strahlensatz"
      "sinussatz"
    ]
  ]
]

exports.problemDefinitions =
  # someModule : someModule
  einXeins : einXeins
  bruch0 : fractions.bruch0
  bruch1 : fractions.bruch1
  bruch2 : fractions.bruch2
  bruch3 : fractions.bruch3
  bruch4 : fractions.bruch4
  proportionality : proportionality
  terme1 : expressions
  ausklammern : ausklammern
  lineareGleichung1 : linearEquations.lineareGleichung1
  lineareGleichung2 : linearEquations.lineareGleichung2
  binomischeFormeln : binomischeFormeln
  quadratischeGleichung : quadratischeGleichung
  potenz1 : powers.potenz1
  nullStellen : nullstellen
  scheitelpunkt : scheitelpunkt
  polynomialDivision : polynomialDivision
  differentiation : differentiation
  integration : integration
  templateTest : templateTest
  functionPlotTest : functionPlotTest
  linearFunctions : linearFunctions
  quadraticFunctions : quadraticFunctions
  strahlensatz : strahlensatz
  sinussatz : sinussatz
  # test :
  #   title : "Test"
  #   description : "Testbereich für den Aufgabengenerator, \
  #     an dem ich gerade rumprogrammiere"
  #   problems : [
  #     levels : [1..5]
  #     generator : fractionGenerator.test
  #   ]
