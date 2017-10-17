{ Rnd } = require "../randomGenerators.coffee"
rnd = new Rnd()

{ Check } = require "../checks.coffee"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

math = require "mathjs"

exports.scheitelpunktGenerator = generator =
  form : (level = 1, language="de") ->
    [xs, ys] = rnd.ints 9
    a = rnd.int2Plus 9
    op1 = rnd.opMinus()
    [op2, op3] = rnd.opsStrich()
    coeff = if level > 1 then "#{op1}#{a}" else ""
    scheitelpunktForm = "#{coeff}(x#{op2}#{xs})^2#{op3}#{ys}"
    expanded = nerdamer("expand(#{scheitelpunktForm})")
    #return
    problem : "f(x)=#{expanded}"
    problemTeX : "f(x)=#{expanded.toTeX()}"
    solution: "f(x)=#{scheitelpunktForm}"
    description : "Bringe die Quadratische Funktion in die Scheitelpunktform."
    checks : [
      Check.equivalent
      Check.scheitelpunktForm
    ]

exports.scheitelpunkt =
  title :
    de : "Scheitelpunkt Quadratischer Funktionen"
  description :
    de : "Scheitelpunkt und Scheitelpunktform"
  problems : [
    levels : [1..2]
    generator : generator.form
  ]
