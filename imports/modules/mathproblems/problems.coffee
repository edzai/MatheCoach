_ = require "lodash"

exports.problems =
  modul1 :
    title : "Modul 1: Bruchrechnen"
    problems : [
      expression : "vn0 / vn1 vo0 (vn2 / vn3)"
      randomGenerator : "vo0notDivision"
      description : "Löse die einfach Bruchrechenaufgabe:"
    ,
      expression : "vn0 / vn1 vo0 (vn2 / vn1)"
      randomGenerator : "standard"
      description : "Löse die einfach Bruchrechenaufgabe:"
    ,
      expression : "vn0 / vn1 vo0 (vn2/vn3 vo1 (vn4/vn5))"
      randomGenerator : "kleinesEinMalEins"
      description : "Löse die einfach Bruchrechenaufgabe:"
    ]
  modul2 :
    title : "Modul 2: Gleichungen"
    problems : [
      expression : "vn0 vc0 vo0 vn1 = vn2"
      randomGenerator : "standard"
      description : "Löse die Gleichung nach vc0 auf:"
    ,
      expression : "vn0 vc0 vo0 (vn1 vc1) = vn2"
      randomGenerator : "vo0notMultiplication"
      description : "Löse die Gleichung nach vc0 auf:"
    ]

exports.randomGenerators =
  standard : ->
    vn : (_.random(1,20) for i in [0..9])
    vc : _.sampleSize "abcdefghijklmnopqrstuvwxyz".split(""), 10
    vo : (_.sample "+-*/".split("") for i in [0..9])
  kleinesEinMalEins : ->
    rndObj = @standard()
    rndObj.vn = (_.random(1,10) for i in [0..9])
    rndObj
  vo0notDivision : ->
    rndObj = @standard()
    rndObj.vo[0] = _.sample "+-*".split("")
    rndObj
  vo0notMultiplication : ->
    rndObj = @standard()
    rndObj.vo[0] = _.sample "+-/".split("")
    rndObj
