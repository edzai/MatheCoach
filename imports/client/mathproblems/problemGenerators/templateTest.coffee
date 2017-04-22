{ Rnd } = require "../randomGenerators.coffee"
rnd = new Rnd()

{ Check } = require "../checks.coffee"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

{ Point } = require "/imports/client/geometryDraw.coffee"

# require "./templates/templateTestTemplate/templateTestTemplate.coffee"
require "./templates/svgTestTemplate/svgTestTemplate.coffee"

generators =
  pythagoras1 : (level = 1) ->
    [la, lb] = rnd.intsMin 80, 140
    phi = rnd.intMin 0, 359
    unit = "cm"
    #returns
    problem : "not used"
    solution : ((la**2 + lb**2)**.5).toFixed 1
    description : "Satz des Pythagoras"
    customTemplateName : "svgTestTemplate"
    customTemplateData : { la, lb, unit , phi }
  pythagoras2 : (level = 1) ->
    [la, lb] = rnd.intsMin 80, 140
    phi = rnd.intMin 0, 359
    unit = "cm"
    triangle =
      type : "polygon"
      lines : [
          startPoint : new Point 0, 0
          pointLabelText : "B"
          # angleLabelText : "β"
          lineLabelText : "a = #{la}#{unit}"
        ,
          startPoint : new Point 0, la
          pointLabelText : "C"
          # angleLabelText : "⋅"
          lineLabelText : "b = #{lb}#{unit}"
        ,
          startPoint : new Point lb, la
          pointLabelText : "A"
          # angleLabelText : "α"
          lineLabelText : "c = ?"
        ].map (e) ->
          e.startPoint = e.startPoint
            .add(new Point 100-lb/2, 100-la/2)
            .rotate phi, (new Point 100, 100)
          e
    #returns
    problem : "not used"
    solution : ((la**2 + lb**2)**.5).toFixed 1
    description : "Bestimme die Länge der Hypothenuse c"
    hint : "Benutze den Satz des Pythagoras. Runde das Ergebnis auf eine Stelle hinter dem Komma."
    geometryDrawData : [triangle]
    skipExpression : true

exports.templateTest =
  title : "Test: Graphikmodul"
  description : "Dies ist lediglich ein Test und nicht als Übungsmodul
    für Schüler gedacht"
  problems : [
    levels : [1]
    generator : generators.pythagoras2
  ]
