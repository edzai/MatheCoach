_ = require "lodash"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

math = require "mathjs"

{ Fraction, Expression, Equation } = algebra = require "algebra.js"

require "/imports/modules/ASCIIMathTeXImg.js"

katex = require "katex"
require "katex/dist/katex.min.css"

{ problems, randomGenerators }  = require "./problems.coffee"

exports.checkAnswer = ({ answer, solution }) ->
  if "=" in solution.split ""
    solution = solution.split("=")[1]
  #difference = nerdamer("(#{answer}) - (#{solution})")
  #console.log "checkAnswer", answer, solution, difference.text()
  #console.log nerdamer("(a+b) - (a+b)").text() # 2*(a+b) WTF???
  difference = algebra.parse(answer).subtract(algebra.parse(solution))
  difference.toString() is "0"

exports.getProblem = getProblem = (module) ->
  try
    problem = randomProblem(module)
    solutionAM =
      unless "=" in problem.AM.split ""
        nerdamer(problem.AM).toString()
      else
        nerdamerSolution =
          nerdamer.solveEquations(problem.AM, problem.variables[0]).toString()
        solution = algebra.parse(nerdamerSolution).toString()
        "#{problem.variables[0]} = #{solution}"
    #return:
    title : problems[module].title
    description : problem.description
    problemAM : problem.AM
    solutionAM : solutionAM
    problemHtml : renderAM problem.AM
    solutionHtml : renderAM solutionAM
  catch
    getProblem module

renderTeX = (str) ->
  katex.renderToString str,
    displayMode : true
    throwOnError : false

renderAM = (str) ->
  renderTeX TeXifyAM(str)

TeXifyAM = (str) ->
  unless "=" in str.split ""
    node = math.parse str
    node.toTex
      parenthesis : "auto"
      implicit : "hide"
  else
    (TeXifyAM part for part in str.split "=").join "="


randomProblem = (module) ->
  pick = _.cloneDeep(_.sample problems[module].problems)
  { vn, vc, vo } = randomGenerators[pick.randomGenerator]()
  pick.expression =
    pick.expression
      .replace /vn(\d)/g, (match,n) -> vn[n]
      .replace /vc(\d)/g, (match,n) -> vc[n]
      .replace /vo(\d)/g, (match,n) -> vo[n]
  pick.description =
    pick.description
      .replace /vc(\d)/g, (match,n) -> vc[n]
  #return:
  title : problems[module].title
  description : pick.description
  AM : pick.expression
  variables : vc
