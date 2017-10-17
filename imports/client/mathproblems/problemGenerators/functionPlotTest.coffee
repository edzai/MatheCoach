{ Rnd } = require "../randomGenerators.coffee"
rnd = new Rnd()

{ Check } = require "../checks.coffee"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

generators =
  standardparabel : (level = 1, language="de") ->
    problem : "f(x)=x^2"
    solution : "1"
    description : "Bestaune den Funktionsplot."
    functionPlotData :
      data : [
        fn : "x^2"
      ]
      xAxis :
        label : "x"
        domain : [-3, 3]
      yAxis :
        label : "f(x)"
        domain : [-.5, 8]
    hint : "Gib dem Programmierer eine Note von 1 bis 6"

exports.functionPlotTest =
  title :
    de : "Test: Funktionsplot"
  description :
    de : "Dies ist lediglich ein Test und nicht als Übungsmodul
    für Schüler gedacht"
  problems : [
    levels : [1]
    generator : generators.standardparabel
  ]
