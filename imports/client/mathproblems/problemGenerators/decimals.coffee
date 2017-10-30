{ Rnd } = require "../randomGenerators.coffee"
rnd = new Rnd()

{ Check } = require "../checks.coffee"

# nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
# require "/imports/modules/nerdamer/Solve.js"

math = require "mathjs"

{ teXifyAM } = require "../renderAM.coffee"

exports.decimalsGenerator = generator =
  addition : (level = 1, language="de") ->
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
    description : switch language
      when "de" then "Addiere die beiden Dezimalzahlen:"
      else "Add the decimal numbers:"

  subtraction : (level = 1, language="de") ->
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
    description : switch language
      when "de" then "Subtrahiere die beiden Dezimalzahlen:"
      else "Subtract the decimal numbers:"

  multiplication : (level = 1, language="de") ->
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
    description : switch language
      when "de" then "Multipliziere die beiden Dezimalzahlen:"
      else "Multiply the decimal numbers:"

  division : (level = 1, language="de") ->
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
    description : switch language
      when "de" then "Dividiere die beiden Dezimalzahlen:"
      else "Do the division:"

exports.decimals =
  decimals1 :
    title :
      de : "Dezimalzahlen 1"
      en : "Decimal Numbers 1"
    description :
      de : "Addition und Subtraktion von Dezimalzahlen"
      en : "Sums and Differences with Decimal Numbers"
    problems : [
      levels : [1..4]
      generator : generator.addition
    ,
      levels : [2..4]
      generator : generator.subtraction
    ]
  decimals2 :
    title :
      de : "Dezimalzahlen 2"
      en : "Decimal Numbers 2"
    description :
      de : "Multiplikation von Dezimalzahlen"
      en : "Multiplying Decimal Numbers"
    problems : [
      levels : [1..3]
      generator : generator.multiplication
    ]
  decimals3 :
    title :
      de : "Dezimalzahlen 3"
      en : "Decimal Numbers 3"
    description :
      de : "Division mit Dezimalzahlen"
      en : "Division with Decimal Numbers"
    problems : [
      levels : [1..3]
      generator : generator.division
    ]
  decimals :
    title :
      de : "Dezimalzahlen"
      en : "Decimal Numbers"
    description :
      de : "Vermische Aufgaben zum Rechnen mit Dezimalzahlen"
      en : "Assorted Problems with Decimal Numbers"
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
