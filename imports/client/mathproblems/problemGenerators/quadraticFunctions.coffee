{ Rnd } = require "../randomGenerators.coffee"
rnd = new Rnd()

_ = require "lodash"

{ Check } = require "../checks.coffee"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

{fitGraph} = require "./linearFunctions.coffee"

generators =
  formulaFromGraph : (level = 1, language="de") ->
    aDenomRoot = rnd.intPlus 3
    aDenom = aDenomRoot**2
    aEnum = rnd.intPlus aDenom
    aSign = rnd.opMinus()
    a = "#{aSign}#{aEnum}/#{aDenom}"
    aSignNum = if aSign is "-" then -1 else 1
    [xs, ys] = rnd.intsMin -3, 3
    problem = "#{a}*(x-#{xs})^2 +#{ys}"
    xmin = xs + aDenomRoot + 1
    xmax = xs - aDenomRoot - 1
    f = (x) -> aSignNum*aEnum/aDenom*(x-xs)**2+ys
    if aSign is "-"
      ymax = ys+1
      ymin = f(xmin)-1
    else
      ymin = ys-1
      ymax = f(xmin)+1
    [xmin, xmax, ymin, ymax] = fitGraph xmin, xmax, ymin, ymax

    #return
    problem : "f(x)=#{problem}"
    solutionTeX : "f(x)=#{nerdamer(problem).toTeX()}"
    skipExpression : true
    description : switch language
      when "de"
        "Gib die Funktionsgleichung für den abgebildeten Graphen an."
      else
        "Find the equation for the displayed function plot."
    functionPlotData :
      data : [
        fn : problem
      ]
      xAxis :
        label : "x"
        domain : [xmin, xmax]
      yAxis :
        label : "f(x)"
        domain : [ymin, ymax]
      grid : true

exports.quadraticFunctions =
  title :
    de : "Quadratische Funktionen"
    en : "Quadratic Equations"
  description :
    de : "Funktionsgleichung vom Graphen ablesen."
    en : "Find the Equation of a Plot."
  problems : [
    levels : [1]
    generator : generators.formulaFromGraph
  ]
