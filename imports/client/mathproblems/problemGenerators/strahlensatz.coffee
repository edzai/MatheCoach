{ Rnd } = require "../randomGenerators.coffee"
rnd = new Rnd()

{ Check } = require "../checks.coffee"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

_ = require "lodash"

{ Point } = require "/imports/client/geometryDraw.coffee"

generators =
  strahlensatz1 : (level = 1) ->
    #construct 2 similar triangles with integer sides lengths
    minLength = 7
    maxLength = 19
    #rollDice = ->
    [ar,br] = rnd.uniqueIntsMin minLength, maxLength
    minBaseLength = Math.abs(ar-br) + minLength
    maxBaseLength = ar + br - minLength
    cr = rnd.intMin minBaseLength, maxBaseLength
    kd = rnd.intMin 4, 7
    kn = rnd.intMin 2, kd-2
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
    #do transforms to fit it nicely into 200x200 viewport
    triangleMiddle = A.add(B).add(C).multiply(1/3)
    rmax = _.max [A,B,C].map (p) ->
      p.distance triangleMiddle
    [A,B,C,Cs,Bs,triangleMiddle] =
      [A,B,C,Cs,Bs,triangleMiddle].map (p) -> p.multiply(85/rmax)
    O = new Point 100, 100
    phi = rnd.int 360
    [A,B,C,Cs,Bs] =
      [A,B,C,Cs,Bs].map (p,i) ->
        point :
          p.add O
          .subtract triangleMiddle
          .rotate phi, O
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
    #console.log {a,b,c,as,bs,cs,k,rmax,A,B,C,Bs,Cs}
    #returns
    problem : "not used"
    solution : solution
    description : "Bestimme den gesuchten Wert mit dem \
      #{strahlensatz}. Strahlensatz"
    hint : "Bruchrechnen ist dein Freund."
    geometryDrawData : [triangleBig, triangleSmall]
    skipExpression : true

exports.strahlensatz =
  title : "Strahlensätze"
  description : "Aufgaben zum 1. und 2. Strahlensatz"
  problems : [
    levels : [1]
    generator : generators.strahlensatz1
  ]
