
{ strichrechnungGanzzahlig, strichrechnungRational } =
  require "./problemGenerators/addition.coffee"
{ fractions } =
  require "./problemGenerators/fractions.coffee"
{ decimals } =
  require "./problemGenerators/decimals.coffee"
{ units } =
  require "./problemGenerators/units.coffee"
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
# { templateTest } =
#   require "./problemGenerators/templateTest.coffee"
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
{ linGlSys } =
  require "./problemGenerators/linGlSys.coffee"
{ prismen } =
  require "./problemGenerators/prismen.coffee"
{ circleTest } =
  require "./problemGenerators/circleTest.coffee"
# { someModule } =
#   require "./problemGenerators/some.coffee"

exports.moduleKeys = [
  "strichrechnungGanzzahlig"
  "strichrechnungRational"
  "einXeins"
  "bruch0"
  "bruch1"
  "bruch2"
  "bruch3"
  "bruch4"
  "decimals1"
  "decimals2"
  "decimals3"
  "decimals"
  "lengthUnits"
  "areaUnits"
  "volumeUnits"
  "mixedUnits"
  "potenz1"
  "potenz2"
  "proportionality"
  "terme1"
  "ausklammern"
  "binomischeFormeln"
  "lineareGleichung1"
  "lineareGleichung2"
  "quadratischeGleichung"
  "linearFunctions"
  "scheitelpunkt"
  "nullStellen"
  "differentiation"
  "integration"
  "polynomialDivision"
  # "templateTest"
  "quadraticFunctions"
  "strahlensatz"
  "sinussatz"
  "linGlSys"
  "prismen"
]

exports.modules = [
  title :
    de : "Aufgaben nach Themen"
  kindred : [
    title :
      de : "Grundrechenarten"
    description :
      de : "Die Grundlagen, die einfach sitzen müssen."
    kindred : [
      "strichrechnungGanzzahlig"
      "strichrechnungRational"
      "einXeins"
      "decimals1"
      "decimals2"
      "decimals3"
      "decimals"
      "proportionality"
    ]
  ,
    title :
      de : "Bruchrechnen"
    description :
      de : "Bruchrechnen ist euer Freund!"
    kindred : [
      "bruch0"
      "bruch1"
      "bruch2"
      "bruch3"
      "bruch4"
    ]
  ,
    title :
      de : "Rechnen mit Einheiten"
    description :
      de : "Einheiten weglassen rächt sich."
    kindred : [
      "lengthUnits"
      "areaUnits"
      "volumeUnits"
      "mixedUnits"
    ]
  ,
    title :
      de : "Potenzrechnung"
    description :
      de : "Rechengesetze für Potenzen und Wurzeln."
    kindred : [
      "potenz1"
      "potenz2"
    ]
  ,
    title :
      de : "Terme umformen"
    description :
      de : "Terme zusammenfassen, Umgang mit Klammern"
    kindred : [
      "terme1"
      "ausklammern"
      "binomischeFormeln"
      "polynomialDivision"
    ]
  ,
    title :
      de : "Gleichungen"
    description :
      de : "Lineare und Quadratische Gleichungen Lösen"
    kindred : [
      "lineareGleichung1"
      "lineareGleichung2"
      "quadratischeGleichung"
      "linGlSys"
    ]
  ,
    title :
      de : "Funktionen"
    description :
      de : "Funktionen, Graphen, Funktionsgleichungen"
    kindred : [
      "linearFunctions"
      "scheitelpunkt"
      "nullStellen"
      "quadraticFunctions"
    ]
  ,
    title :
      de : "Geometrie"
    description :
      de : "Vermischte Aufgaben"
    kindred : [
      "strahlensatz"
      "prismen"
    ]
  ,
    title :
      de : "Calculus"
    description :
      de : "Differential/Integralrechnung"
    kindred :[
      "differentiation"
      "integration"
    ]
  ,
    title :
      de : "Area 51"
    description :
      de : "Testgebiet für Aufgabengeneratoren \
      an denen ich noch arbeite. Benutzung auf eigene Gefahr."
    kindred : [
      # "templateTest"
      "sinussatz"
      "circleTest"
    ]
  ]
]

exports.problemDefinitions =
  # someModule : someModule
  strichrechnungGanzzahlig : strichrechnungGanzzahlig
  strichrechnungRational : strichrechnungRational
  einXeins : einXeins
  bruch0 : fractions.bruch0
  bruch1 : fractions.bruch1
  bruch2 : fractions.bruch2
  bruch3 : fractions.bruch3
  bruch4 : fractions.bruch4
  decimals1 : decimals.decimals1
  decimals2 : decimals.decimals2
  decimals3 : decimals.decimals3
  decimals : decimals.decimals
  lengthUnits : units.length
  areaUnits : units.area
  volumeUnits : units.volume
  mixedUnits : units.mix
  proportionality : proportionality
  terme1 : expressions
  ausklammern : ausklammern
  lineareGleichung1 : linearEquations.lineareGleichung1
  lineareGleichung2 : linearEquations.lineareGleichung2
  binomischeFormeln : binomischeFormeln
  quadratischeGleichung : quadratischeGleichung
  potenz1 : powers.potenz1
  potenz2 : powers.potenz2
  nullStellen : nullstellen
  scheitelpunkt : scheitelpunkt
  polynomialDivision : polynomialDivision
  differentiation : differentiation
  integration : integration
  # templateTest : templateTest
  functionPlotTest : functionPlotTest
  linearFunctions : linearFunctions
  quadraticFunctions : quadraticFunctions
  strahlensatz : strahlensatz
  sinussatz : sinussatz
  linGlSys : linGlSys
  prismen : prismen
  circleTest : circleTest
  # test :
  #   title : "Test"
  #   description : "Testbereich für den Aufgabengenerator, \
  #     an dem ich gerade rumprogrammiere"
  #   problems : [
  #     levels : [1..5]
  #     generator : fractionGenerator.test
  #   ]
