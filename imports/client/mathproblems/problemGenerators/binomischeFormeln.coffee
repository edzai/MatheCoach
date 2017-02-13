{ Rnd } = require "../randomGenerators.coffee"
rnd = new Rnd()

{ Check } = require "../checks.coffee"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

math = require "mathjs"

#TODO fix checks
#nerdamer doesnt recognize that (a+b)^2-(a^2+2ab+b^2) is 0
#so we don't have to worry about checking if the problem was
#actually solved. but the checks should actually say it's equivalent...

exports.binomischeFormelnGenerator = generator =
  einfach : (level = 1) ->
    [na, nb] = rnd.intsPlus 9
    [va, vb] = rnd.uniqueLetters()
    [a, b] = ["#{na}#{va}", "#{nb}#{vb}"]
    vab = [va, vb].sort().join("*")
    switch formelN = rnd.intPlus 3
      when 1
        leftSide = "(#{a}+#{b})^2"
        rightSide = "(#{na**2}#{va}^2 + #{2*na*nb}#{vab} + #{nb**2}#{vb}^2)"
      when 2
        leftSide = "(#{a}-#{b})^2"
        rightSide = "(#{na**2}#{va}^2 - #{2*na*nb}#{vab} + #{nb**2}#{vb}^2)"
      else
        leftSide = "(#{a}+#{b})*(#{a}-#{b})"
        rightSide = "(#{na**2}#{va}^2 - #{nb**2}#{vb}^2)"
    switch level
      when 1
        problem = leftSide
        solution = rightSide
      else
        problem = rightSide
        solution = leftSide
    #return
    problem : problem
    solution : solution
    description : "Wende die entsprechende Binomische Formel an."

exports.binomischeFormeln =
  title : "Binomische Formeln"
  description : "Ohne die ist man bei Quadratischen Funktionen aufgeschmissen."
  problems : [
    levels : [1..2]
    generator : generator.einfach
  ]
