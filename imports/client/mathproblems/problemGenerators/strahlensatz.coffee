{ Rnd } = require "../randomGenerators.coffee"
rnd = new Rnd()

{ Check } = require "../checks.coffee"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

{ Point } = require "/imports/client/geometryDraw.coffee"

generators =
  strahlensatz1 : (level = 1) ->
    showName = false
    [a,b,c,as,bs,cs] = ({} for n in [1..6])
    [b.value, Bx, By] = rnd.intsMin 100, 170
    k = (rnd.intMin 20, 80)/100
    A = new Point 0, 0
    B = new Point Bx, By
    C = new Point b.value, 0
    Bs = B.multiply k
    Cs = C.multiply k
    phi = rnd.int 360
    a.value = C.subtract(B).length()
    c.value = B.length()
    as.value = a.value*k
    cs.value = c.value*k
    bs.value = b.value*k
    [A, B, C, Bs, Cs] = [A, B, C, Bs, Cs].map (p) ->
      triangleMiddle = A.add(B).add(C).multiply(1/3)
      p.add(new Point 100, 100)
      .subtract(triangleMiddle)
      .rotate phi, (new Point 100, 100)
    strahlensatz = rnd.intMin 1,2
    if strahlensatz is 1
      a.dontShow = as.dontShow = true
      answer = _.sample [b,c,bs,cs]
      answer.isAnswer = true
      solution = answer.value.toFixed 0
    else
      b.dontShow = bs.dontShow = true
      answer = _.sample [a,c,as,cs]
      answer.isAnswer = true
      solution = answer.value.toFixed 0
    formatLength = (l) ->
      if l.isAnswer then "?"
      else if l.dontShow then ""
      else "#{l.value.toFixed 1}"
    buildLines = (arr) ->
      arr.map (l) ->
        startPoint : l[0]
        pointLabelText : ""
        angleLabelText : ""
        lineLabelText : formatLength l[1]
    triangleBig =
      type : "polygon"
      lines : buildLines [[A,c],[B,a],[C,b]]
    triangleSmall =
      type : "polygon"
      lines :
        if k < .5
          buildLines [[A,cs],[Bs,as],[Cs,bs]]
        else
          #put the labels on the inside
          buildLines [[A,bs],[Cs,as],[Bs,cs]]
    #returns
    problem : "not used"
    solution : solution
    description : "Bestimme den gesuchten Wert mit dem \
      #{strahlensatz}. Strahlensatz"
    hint : "Runde das Ergebnis auf eine ganze Zahl."
    geometryDrawData : [triangleBig, triangleSmall]
    skipExpression : true

exports.strahlensatz =
  title : "Strahlensätze"
  description : "Aufgaben zum 1. und 2. Strahlensatz"
  problems : [
    levels : [1]
    generator : generators.strahlensatz1
  ]
