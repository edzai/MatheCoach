{ Rnd } = require "../randomGenerators.coffee"
rnd = new Rnd()

_ = require "lodash"

{ Check } = require "../checks.coffee"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

{ Point } = require "/imports/client/geometryDraw.coffee"

generators =
  sinussatz : (level = 1) ->
    [a,b,c,alpha,beta,gamma] = ({} for n in [1..6])
    [b.value, Bx, By] = rnd.intsMin 100, 170
    phi = rnd.int 360
    A = new Point 0, 0
    B = new Point Bx, By
    C = new Point b.value, 0
    a.value = C.subtract(B).length()
    c.value = B.length()
    alpha.value = C.innerAngle B, A
    beta.value = A.innerAngle C, B
    gamma.value = B.innerAngle A, C
    offset = (new Point 100, 100).subtract(A.add(B).add(C).multiply(1/3))
    [A,B,C] = [A,B,C].map (p) ->
      p.add(offset).rotate phi, (new Point 100, 100)
    answer = {}
    switch level
      when 1
        gamma.dontShow = c.dontShow = true
        answer = _.sample([a, b])

      when 2
        gamma.dontShow = c.dontShow = true
        answer = _.sample([a, alpha, b, beta])
      else
        _.sample([alpha, beta, gamma]).dontShow = true
        pick = _.sampleSize [a,b,c], 2
        pick[0].dontShow = true
        answer = pick[1]
    answer.isAnswer = true
    solution = answer.value.toFixed 0
    triangle =
      type : "polygon"
      lines :
        [[A, alpha, c], [B, beta, a], [C, gamma, b]].map (line) ->
          startPoint : line[0]
          pointLabelText : ""
          angleLabelText :
            if line[1].dontShow then ""
            else if line[1].isAnswer then "?"
            else "#{line[1].value.toFixed 1}°"
          lineLabelText :
            if line[2].dontShow then ""
            else if line[2].isAnswer then "?"
            else "#{line[2].value.toFixed 1}"
    #returns
    problem : "not used"
    solution : solution
    description : "Bestimme den gesuchten Wert mit Hilfe \
      des Sinussatzes."
    hint : "Runde das Ergebnis auf eine ganze Zahl."
    geometryDrawData : [triangle]
    skipExpression : true

exports.sinussatz =
  title : "Der Sinussatz"
  description : "Aufgaben zum Verhältnis von Winkeln zu Seitenlängen in Dreiecken"
  problems : [
    levels : [1..3]
    generator : generators.sinussatz
  ]
