{ Rnd } = require "../randomGenerators.coffee"
rnd = new Rnd()

{ Check } = require "../checks.coffee"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

_ = require "lodash"

{ Point, umkreis } = require "/imports/client/mathproblems/geometryDraw.coffee"

generators =
  strahlensatz1 : (level = 1, language="de") ->
    #construct 2 similar triangles with integer sides lengths
    [minLength, maxLength, minDenom, maxDenom] = switch level
      when 1 then [7, 19, 4, 7]
      when 2 then [7, 23, 5, 9]
      else [7, 37, 7, 17]
    [ar,br] = rnd.uniqueIntsMin minLength, maxLength
    minBaseLength = Math.abs(ar-br) + minLength
    maxBaseLength = ar + br - minLength
    cr = rnd.intMin minBaseLength, maxBaseLength
    kd = rnd.intMin minDenom, maxDenom
    kn = rnd.intMin minDenom-2, kd-2
    k = kn/kd
    [as, bs, cs] = [ar, br, cr].map (n) -> n*kn
    [a, b, c] = [ar, br, cr].map (n) -> n*kd
    A = new Point 0, 0
    B = new Point c, 0
    Cx = (a**2-b**2-c**2)/(-2*c)
    Cy = -(b**2-Cx**2)**.5
    C = new Point Cx, Cy
    Cs = C.multiply k
    Bs = B.multiply k
    #scale it to fit a circle with r=90
    maxr = umkreis(A,B,C).radius
    [A,B,C,Cs,Bs] =
      [A,B,C,Cs,Bs].map (p) ->
        p.multiply(90/maxr)
    phi = rnd.int 360
    [A,B,C,Cs,Bs] =
      [A,B,C,Cs,Bs].map (p,i) ->
        point :
          p.rotate phi
        name : ["A","B","C","Cs","Bs"][i]
    #turn values into Objects, so we can keep track of stuff
    [a,b,c,as,bs,cs] =
      [a,b,c,as,bs,cs].map (n,i) ->
        value : n
        dontShow : false
        isAnswer : false
        name : ["a","b","c","as","bs","cs"][i]
    #pick values for different flavors of problems
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
      else "#{l.value}"
    buildLines = (arr) ->
      arr.map (l) ->
        startPoint : l[0].point
        pointLabelText : "" #l[0].name
        angleLabelText : ""
        lineLabelText :
          unless l[1].name in ["b","c"] then formatLength l[1] else ""
        measureText :
          if l[1].name in ["b","c"]
            unless l[1].dontShow then formatLength l[1]
    triangleBig =
      type : "polygon"
      lines : buildLines [[A,c],[B,a],[C,b]]
    triangleSmall =
      type : "polygon"
      lines :
        #put the labels on the inside
        buildLines [[A,cs],[Bs,as],[Cs,bs]]
    centerCircle =
      type : "circle"
      center : new Point 100, 100
      radius : 5
    #returns
    problem : "not used"
    solution : solution
    description : switch language
      when "de"
        "Bestimme den gesuchten Wert mit dem \
        #{strahlensatz}. Strahlensatz"
      else
        "Find the indicated value using the intercept theorem."
    hint : switch language
      when "de"
        "Bruchrechnen ist dein Freund."
      else
        "Use fractions to solve this problems."
    geometryDrawData : [triangleBig, triangleSmall]
    skipExpression : true

exports.strahlensatz =
  title :
    de : "Strahlensätze"
    en : "Intercept Theorems"
  description :
    de : "Aufgaben zum 1. und 2. Strahlensatz"
    en : "Problems about the first two Inercept Theorems"
  problems : [
    levels : [1..3]
    generator : generators.strahlensatz1
  ]
