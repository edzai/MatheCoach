{ Rnd } = require "../randomGenerators.coffee"
rnd = new Rnd()

{ re } = require "../RegExs.coffee"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

{ teXifyAM } = require "../renderAM.coffee"

#math = require "mathjs"

_ = require "lodash"

exports.processEquation = processEquation = (equation, variable) ->
  doWithSides = (fkt) ->
    equation.split("=").map(fkt).join("=")
  expandedEquation = doWithSides (side) ->
    nerdamer("expand(#{side})").text "fractions"
  expandedEquationTeX = doWithSides (side) ->
    nerdamer("expand(#{side})").toTeX()
  solutionArray =
    nerdamer.solveEquations(expandedEquation, variable).toString().split ","
  solution = _(solutionArray).uniq().value().join ","
  elementsTeX =
    solution.split ","
      .map (e) -> nerdamer(e).toTeX()
      .join ","
  solutionTeX = "\\mathbb{L}=\\left\\{#{elementsTeX}\\right\\}"
  #return
  problem : expandedEquation
  problemTeX : expandedEquationTeX
  solution : solution
  solutionTeX : solutionTeX

exports.quadraticEquationGenerator = quadraticEquationGenerator =
  intsOnly : (level = 1) ->
    x = rnd.letter()
    [a, b, c, d, e, f, g] = rnd.intsPlus(9)
    [op1, op2, op3, op4, op5, op6, op7] = rnd.opsStrich()
    switch level
      when 1
        [op1, op3] = ["", ""]
        [a,c] = ["",""]
        [e, f, g] = [0, 0, 0]
        x = "x"
      when 2
        [op1, op3] = ["", ""]
        [a,c] = ["",""]
        [e, f] = [0, 0]
      when 3
        op3 = ""
        c = ""
        e = 0
      when 4
        op3 = ""
        c = ""
    offset = "#{op5}#{e}#{x}^2#{op6}#{f}#{x}#{op7}#{g}"
    problem = "(#{op1}#{a}#{x}#{op2}#{b})\
      (#{op3}#{c}#{x}#{op4}#{d})#{offset}=#{offset}"
    processed = processEquation problem, x
    #return
    problem : processed.problem
    problemTeX : processed.problemTeX
    solution : processed.solution
    solutionTeX : processed.solutionTeX
    description : "Löse die Quadratische Gleichung für #{x}:"

exports.quadratischeGleichung =
  title : "Quadratische Gleichungen"
  description :
    "Einfache Quadratische Gleichungen Lösen (z.B. mit der pq-Formel)"
  problems : [
    levels : [1..5]
    generator : quadraticEquationGenerator.intsOnly
  ]
