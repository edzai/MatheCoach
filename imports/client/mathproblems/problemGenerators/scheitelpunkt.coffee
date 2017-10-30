{ Rnd } = require "../randomGenerators.coffee"
rnd = new Rnd()

{ Check } = require "../checks.coffee"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

math = require "mathjs"

#TODO: Actually make problem that asks for the vertex

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
    description : switch language
      when "de"
        "Bringe die Quadratische Funktion in die Scheitelpunktform."
      else
        "Transform the quadratic equation into vertex form."
    checks : [
      Check.equivalent
      Check.scheitelpunktForm
    ]

exports.scheitelpunkt =
  title :
    de : "Scheitelpunkt Quadratischer Funktionen"
    en : "Vertex of Quadratic Functions"
  description :
    de : "Scheitelpunkt und Scheitelpunktform"
    en : "Vertex and Vertex Form"
  problems : [
    levels : [1..2]
    generator : generator.form
  ]
