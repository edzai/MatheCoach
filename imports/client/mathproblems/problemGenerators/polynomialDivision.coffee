{ Rnd } = require "../randomGenerators.coffee"
rnd = new Rnd()

{ Check } = require "../checks.coffee"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

math = require "mathjs"

exports.polynomialDivisionGenerator = polynomialDivisionGenerator =
  division : (level = 1, language="de") ->
    switch level
      when 1
        numDegree = 2
        denomDegree = 1
      when 2
        numDegree = 3
        denomDegree = 1
      when 3
        numDegree = 3
        denomDegree = 2
      when 4
        numDegree = 4
        denomDegree = 2
      else
        numDegree = 5
        denomDegree = 3
    coeffs = rnd.ints(9)
    ops = rnd.opsStrich()
    makePoly = (start, degree) ->
      rawPoly = ("(x#{ops[i]}#{coeffs[i]})" for i in [start..degree]).join "*"
      nerdamer("expand(#{rawPoly})").text "fractions"
    numerator = makePoly 1, numDegree
    numeratorTeX = nerdamer(numerator).toTeX()
    denominator = makePoly 1, denomDegree
    denominatorTeX = nerdamer(denominator).toTeX()
    solution = makePoly denomDegree+1, numDegree
    #return
    problem : "not used"
    problemTeX : "\\frac{#{numeratorTeX}}{#{denominatorTeX}}"
    solution : solution
    solutionTeX : nerdamer(solution).toTeX()
    description : switch language
      when "de" then "Kürze den Bruch:"
      else "Reduce the Fraction:"

exports.polynomialDivision =
  title :
    de : "Polynomdivision"
    en : "Dividing Polynomials"
  description :
    de : "Nicht so schlimm, wie es zunächst aussieht."
    en : "Not as bad as it looks."
  problems : [
    levels : [1..5]
    generator : polynomialDivisionGenerator.division
  ]
