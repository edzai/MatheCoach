{ Rnd } = require "../randomGenerators.coffee"
rnd = new Rnd()

{ circleTestTextBook } = require "./circleTestTextBook.coffee"

{ Check } = require "../checks.coffee"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

{ Point } = require "/imports/client/geometryDraw.coffee"

generators =
  circle : (level = 1) ->
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

    #returns
    problem : "not used"
    solution : "1"
    description : "Test: Beschrifteter Kreis"
    hint : "Das ist keine Aufgabe, das ist nur ein Programmtest."
    geometryDrawData : [circle1, circle2]
    skipExpression : true
    textBook : circleTestTextBook

exports.circleTest =
  title : "Kreise"
  description : "Test: Beschriftete Kreise in Geometrie Zeichnungen"
  problems : [
    levels : [1]
    generator : generators.circle
  ]
