{ Rnd } = require "../randomGenerators.coffee"
rnd = new Rnd()

{ Check } = require "../checks.coffee"

# nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
# require "/imports/modules/nerdamer/Solve.js"

math = require "mathjs"

{ teXifyAM } = require "../renderAM.coffee"

exports.decimalsGenerator = generator =
  addition : (level = 1) ->
    math.config
      number : "BigNumber"
      precision : 8
    [enu, deno] = switch level
      when 1 then [99, 10]
      when 2 then [999, 100]
      else
        [9999, 100]
    [a, b] = rnd.intsPlus(enu).map (i) -> math.eval("#{i}/#{deno}")
    problem = "#{a} + #{b}"
    #returns
    problem : problem
    solution : math.eval(problem, {a,b}).toString()
    description : "Addiere die beiden Dezimalzahlen"
  subtraction : (level = 1) ->
    math.config
      number : "BigNumber"
      precision : 8
    [enu, deno] = switch level
      when 1 then [99, 10]
      when 2 then [999, 100]
      else
        [9999, 100]
    [a, b] = rnd.intsPlus(enu).map (i) -> math.eval("#{i}/#{deno}")
    problem = "#{a} - #{b}"
    #returns
    problem : problem
    solution : math.eval(problem, {a,b}).toString()
    description : "Subtrahiere die beiden Dezimalzahlen"
  multiplication : (level = 1) ->
    math.config
      number : "BigNumber"
      precision : 12
    [enu, deno] = switch level
      when 1 then [99, 10]
      when 2 then [999, 100]
      else
        [9999, 100]
    [a, b] = rnd.intsPlus(enu).map (i) -> math.eval("#{i}/#{deno}")
    problem = "#{a} * #{b}"
    #returns
    problem : problem
    solution : math.eval(problem, {a,b}).toString()
    description : "Multipliziere die beiden Dezimalzahlen"
  division : (level = 1) ->
    math.config
      number : "BigNumber"
      precision : 12
    [enu, deno] = switch level
      when 1 then [99, 10]
      when 2 then [999, 100]
      else
        [9999, 100]
    [a, b] = rnd.intsPlus(enu).map (i) -> math.eval("#{i}/#{deno}")
    scope = {a,b}
    c=math.eval("a*b", scope)
    #returns
    problem : "not Used"
    problemTeX : "#{c} : #{a}"
    solution : "#{b}"
    description : "Dividiere die beiden Dezimalzahlen"

exports.decimals =
  decimals1 :
    title : "Dezimalzahlen 1"
    description : "Addition und Subtraktion von Dezimalzahlen"
    problems : [
      levels : [1..4]
      generator : generator.addition
    ,
      levels : [2..4]
      generator : generator.subtraction
    ]
  decimals2 :
    title : "Dezimalzahlen 2"
    description : "Multiplikation von Dezimalzahlen"
    problems : [
      levels : [1..3]
      generator : generator.multiplication
    ]
  decimals3 :
    title : "Dezimalzahlen 3"
    description : "Division mit Dezimalzahlen"
    problems : [
      levels : [1..3]
      generator : generator.division
    ]
  decimals :
    title : "Dezimalzahlen"
    description : "Vermische Aufgaben zum Rechnen mit Dezimalzahlen"
    problems : [
      levels : [1..3]
      generator : generator.addition
    ,
      levels : [1..3]
      generator : generator.subtraction
    ,
      levels : [1..3]
      generator : generator.multiplication
    ,
      levels : [1..3]
      generator : generator.division
    ]
