{ Rnd } = require "../randomGenerators.coffee"
rnd = new Rnd()

{ Check } = require "../checks.coffee"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"
#math = require "mathjs"

generators =
  dreisatz : (level = 1, language="de") ->
    [a, b] = rnd.uniqueIntsPlus 10
    c = switch level
      when 1, 2 then Number(((rnd.int 100) / 10).toFixed 2)
      else Number(((rnd.int 1000) / 100).toFixed 2)
    [nameThing, nameProduct] = switch level
      when 1 then [rnd.thing(), -> "€"]
      else rnd.uniqueThings()
    verb = switch level
      when 1
        (n) -> if n in [0,1] then "kostet" else "kosten"
      else rnd.verb()
    #return
    problem : "not used"
    description :
      "#{a} #{nameThing(a)} #{verb(a)} #{(a*c).toFixed 2} \
       #{nameProduct(a*c)}. Wieviel #{nameProduct(2)} \
       #{verb(b)} #{b} #{nameThing(b)}?"
    problemTeX : "\\frac{#{(a*c).toFixed 2}\\text{ #{nameProduct(a*c)}}}\
      {#{a}\\text{ #{nameThing(a)}}} = \\frac{x\\text{ #{nameProduct(2)}}}\
      {#{b}\\text{ #{nameThing(b)}}}"
    solution : "#{(b*c).toFixed 2}"

exports.proportionality =
  title :
    de : "Proportionale Zuordnungen"
  description :
    de : "Oder einfacher ausgedrückt: Der gute alte Dreisatz"
  problems : [
    levels : [1..3]
    generator : generators.dreisatz
  ]
