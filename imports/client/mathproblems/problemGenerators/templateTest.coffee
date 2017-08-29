{ Rnd } = require "../randomGenerators.coffee"
rnd = new Rnd()

{ Check } = require "../checks.coffee"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

{ Point } = require "/imports/client/mathproblems/geometryDraw.coffee"

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
    hint : "Benutze den Satz des Pythagoras. Runde das Ergebnis auf\
      eine Stelle hinter dem Komma."
    geometryDrawData : [triangle]
    skipExpression : true

  areaTriangle : (level = 1) ->
    [g, h] = rnd.intsMin 70, 150
    cx = rnd.intMin 20, g-20
    phi = rnd.int 360
    unit = rnd.lengthUnit()
    A = new Point 0, 0
    B = new Point g, 0
    C = new Point cx, -h
    [A,B,C] = [A,B,C].map (p) ->
      p.add(new Point 100-g/2, 100+h/2)
      .rotate phi, (new Point 100, 100)
    triangle =
      type : "polygon"
      lines : [
        startPoint : A
        pointLabelText : "A"
        angleLabelText : ""
        # angleLabelText : "α"
        lineLabelText : "c = #{g}#{unit}"
      ,
        startPoint : B
        pointLabelText : "B"
        # angleLabelText : "β"
        angleLabelText : ""
        lineLabelText : "a"
      ,
        startPoint : C
        pointLabelText : "C"
        # angleLabelText : "⋅"
        angleLabelText : ""
        lineLabelText : "b"
      ]
    height =
      type : "normal"
      line :
        startPoint : A
        endPoint : B
        p : C
        text : "h=#{h}#{unit}"
    #returns
    problem : "not used"
    solution : (g*h/2).toFixed 1
    description : "Bestimme die Fläche des Dreiecks"
    hint : "Runde das Ergebnis auf eine Stelle hinter dem Komma"
    geometryDrawData : [triangle, height]
    skipExpression : true

  areaTrapez : (level = 1) ->
    [g1, h] = rnd.intsMin 70, 150
    g2 = rnd.intMin 50, g1-20
    g2x = rnd.int g1-g2
    phi = rnd.int 360
    unit = rnd.lengthUnit()
    A = new Point 0 ,0
    B = new Point g1, 0
    C = new Point g2x+g2, -h
    D = new Point g2x, -h
    [A,B,C,D] = [A,B,C,D].map (p) ->
      p.add(new Point 100-g1/2, 100+h/2)
      .rotate phi, (new Point 100, 100)
    trapez =
      type : "polygon"
      lines : [A,B,C,D].map (p, i) ->
        startPoint : p
        pointLabelText : ["A", "B", "C", "D"][i]
        angleLabelText : ""
        lineLabelText : ["a=#{g1}#{unit}", "b", "c=#{g2}#{unit}", "d"][i]
    height =
      type : "normal"
      line :
        startPoint : A
        endPoint : B
        p : C.add(D).multiply(.5)
        text : "h=#{h}#{unit}"
    #return
    problem : "not used"
    solution : ((g1+g2)*h/2).toFixed 1
    description : "Bestimme die Fläche des Trapezes"
    hint : "Runde das Ergebnis auf eine Stelle hinter dem Komma"
    geometryDrawData : [trapez, height]
    skipExpression : true

exports.templateTest =
  title : "Test: Graphikmodul"
  description : "Dies ist lediglich ein Test und nicht als Übungsmodul
    für Schüler gedacht"
  problems : [
    levels : [1]
    generator : generators.areaTriangle
  ,
    levels : [1]
    generator : generators.areaTrapez
  ,
    levels : [1]
    generator : generators.pythagoras2
  ]
