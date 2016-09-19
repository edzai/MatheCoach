#this isn't loaded by meteor
#this is just to run test scripts straight from atom

_ = require "lodash"

nerdamer = require "../nerdamer/nerdamer.core.js"
require "../nerdamer/Solve.js"

math = require "../../../node_modules/mathjs"

{ teXifyAM } =
  require "./renderAM.coffee"

equation = "(x-3)(x+5)=(x+1)(x-1)/2+10"
expandedEquation =
  equation
    .split "="
    .map (side) -> nerdamer("expand(#{side})").text "fractions"
    .join "="
console.log expandedEquation
result = nerdamer.solveEquations(expandedEquation, "x").toString()
resultArray = result.split(",").sort()
console.log resultArray

console.log nerdamer("expand((x+2)(x+3))").toTeX()

console.log nerdamer.solveEquations(['x+y=1', '2*x=6', '4*z+y=6']).toString()
