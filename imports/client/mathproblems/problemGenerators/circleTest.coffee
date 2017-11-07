{ Rnd } = require "../randomGenerators.coffee"
rnd = new Rnd()

{ circleTestTextBook } = require "./circleTestTextBook.coffee"

{ Check } = require "../checks.coffee"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

{ Point } = require "/imports/client/mathproblems/geometryDraw.coffee"

generators =
  circle : (level = 1, language="de") ->
    circle1 =
      type : "circle"
      center : new Point 50, 50
      radius : 45
      centerLabelText : "m"
    circle2 =
      type : "circle"
      center : new Point 120, 120
      radius : 65
      drawRadius : true
      radiusLabelText : "r = 3cm"
      centerLabelText : "c"
    triangle =
      type : "polygon"
      lines : ["a","b","c"].map (lineLabelText, i) ->
        startPoint : (new Point 180, 100).rotate -360/3*i, (new Point 100, 100)
        lineLabelText : lineLabelText
        measureText : "123cm"
    [p1, p2, p3] = triangle.lines.map (line) -> line.startPoint
    measurement1 =
      type : "measurement"
      line :
        startPoint : p1
        endPoint : p2
        text : "123 cm"
    measurement2 =
      type : "measurement"
      line :
        startPoint : p2
        endPoint : p3
        text : "123 cm"
    measurement3 =
      type : "measurement"
      line :
        startPoint : p3
        endPoint : p1
        text : "123 cm"
    #returns
    problem : "not used"
    solution : "1"
    description : "Test: Bemaßungen"
    hint : "Das ist keine Aufgabe, das ist nur ein Programmtest."
    geometryDrawData : [triangle]
    skipExpression : true
    textBook : circleTestTextBook

exports.circleTest =
  title :
    de : "Bemaßungen"
  description :
    de : "Bemaßungen von Strecken mit unterschiedlichen Ebenen"
  problems : [
    levels : [1]
    generator : generators.circle
  ]
