{ Rnd } = require "../randomGenerators.coffee"
rnd = new Rnd()

_ = require "lodash"

{ Check } = require "../checks.coffee"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

{fitGraph} = require "./linearFunctions.coffee"

generators =
  formulaFromGraph : (level = 1) ->
    a = _.
    f = (x) -> signNum*num/denom*x+b
    ymax = f(xmax)
    ymin = f(xmin)
    xRange = Math.abs xmax-xmin
    yRange = Math.abs ymax-ymin
    range = Math.max xRange, yRange
    [xmin, xmax, ymin, ymax] = fitGraph xmin, xmax, ymin, ymax
    problem = "#{m}x+#{b}"
    #return
    problem : problem
    solutionTeX : "f(x)=#{nerdamer(problem).toTeX()}"
    skipExpression : true
    description : "Gib die Funktionsgleichung für den abgebildeten Graphen an"
    functionPlotData :
      data : [
        fn : "#{m}*x+#{b}"
      ]
      xAxis :
        label : "x"
        domain : [xmin, xmax]
      yAxis :
        label : "f(x)"
        domain : [ymin, ymax]
      grid : true

exports.linearFunctions =
  title : "Lineare Funktionen"
  description : "Funktionen deren Graph eine Gerade ist."
  problems : [
    levels : [1]
    generator : generators.standardparabel
  ]
