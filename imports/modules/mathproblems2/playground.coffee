#this isn't loaded by meteor
#this is just to run test scripts straight from atom

_ = require "lodash"

nerdamer = require "../nerdamer/nerdamer.core.js"
require "../nerdamer/Solve.js"

console.log (nerdamer("expand((x+1)^#{n})").text("fractions") for n in [1..30])
