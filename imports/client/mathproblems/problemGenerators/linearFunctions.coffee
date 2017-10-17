{ Rnd } = require "../randomGenerators.coffee"
rnd = new Rnd()

{ Check } = require "../checks.coffee"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

exports.fitGraph = fitGraph = (xmin, xmax, ymin, ymax) ->
  range = Math.max Math.abs(xmax-xmin), Math.abs(ymax-ymin)
  scaleAxis = (min, max) ->
    middle = (min+max)/2
    [middle-range/2, middle+range/2]
  [xminR, xmaxR] = scaleAxis xmin, xmax
  [yminR, ymaxR] = scaleAxis ymin, ymax
  [xminR, xmaxR, yminR, ymaxR]

generators =
  formulaFromGraph : (level = 1, language="de") ->
    b = rnd.intMin -5, 5
    [num, denom] = rnd.intsMin 1, 5
    #make m=1 less likely
    if num is denom then [num, denom] = rnd.intsMin 1, 5
    signStr = rnd.opMinus()
    signNum = if signStr is "-" then -1 else 1
    m = "#{signStr}#{num}/#{denom}"
    xmax = denom + 1
    xmin = if ymax < 4 then -ymax else -1
    f = (x) -> signNum*num/denom*x+b
    ymax = f(xmax)
    ymin = f(xmin)
    [xmin, xmax, ymin, ymax] = fitGraph xmin, xmax, ymin, ymax
    problem = "#{m}x+#{b}"
    #return
    problem : "f(x)=#{problem}"
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
  title :
    de : "Lineare Funktionen"
  description :
    de : "Funktionen deren Graph eine Gerade ist."
  problems : [
    levels : [1]
    generator : generators.formulaFromGraph
  ]
