{ fractions } =
  require "./problemGenerators/fractions.coffee"
{ proportionality } =
  require "./problemGenerators/proportionality.coffee"
{ linearEquations } =
  require "./problemGenerators/linearEquations.coffee"
{ powers } =
  require "./problemGenerators/powers.coffee"
{ expressions } =
  require "./problemGenerators/expressions.coffee"
{ einXeins } =
  require "./problemGenerators/einXeins.coffee"
{ polynomialDivision} =
  require "./problemGenerators/polynomialDivision.coffee"
{ quadratischeGleichung } =
  require "./problemGenerators/quadraticEquations.coffee"
{ nullstellen } =
  require "./problemGenerators/nullstellen.coffee"
# { someModule } =
#   require "./problemGenerators/some.coffee"

exports.modules = [
  "einXeins"
  "bruch0"
  "bruch1"
  "bruch2"
  "bruch3"
  "bruch4"
  "proportionality"
  "terme1"
  "potenz1"
  "lineareGleichung1"
  "lineareGleichung2"
  "quadratischeGleichung"
  "nullStellen"
  "polynomialDivision"
  # "someModule"
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
  lineareGleichung1 : linearEquations.lineareGleichung1
  lineareGleichung2 : linearEquations.lineareGleichung2
  quadratischeGleichung : quadratischeGleichung
  potenz1 : powers.potenz1
  nullStellen : nullstellen
  polynomialDivision : polynomialDivision
  # test :
  #   title : "Test"
  #   description : "Testbereich für den Aufgabengenerator, \
  #     an dem ich gerade rumprogrammiere"
  #   problems : [
  #     levels : [1..5]
  #     generator : fractionGenerator.test
  #   ]
