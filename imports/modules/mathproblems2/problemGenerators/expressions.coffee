{ Rnd } = require "../randomGenerators.coffee"
rnd = new Rnd()

{ re } = require "../RegExs.coffee"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

math = require "mathjs"

exports.expressionGenerator =

  test : (level = 1) ->
    n = switch level
      when 1 then 1
      when 2 then 2
      else 3
    v = rnd.uniqueLetters()
    bits = (
      for i in [1..n]
        for j in [1..2]
          op = rnd.opStrich()
          c = rnd.intPlus()
          "#{op}#{c}#{v[i]}"
    )
    console.log bits
    problem = _.chain(bits).flatten().shuffle().value().join("")
      .split("")[1..].join("")
    console.log problem
    #return
    problem : problem
    description : "Vereinfache den Term:"
    checkSummandsEquivalent : true
