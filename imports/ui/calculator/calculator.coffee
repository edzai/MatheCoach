#require "/imports/ui/mathJax/mathJax.coffee"
require "./calculator.jade"

_ = require "lodash"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

algebra = require "algebra.js"

math = require "mathjs"

{ renderAM, renderTeX, teXifyAM } =
  require "/imports/modules/mathproblems2/renderAM.coffee"


Template.calculator.viewmodel
  input : ""

  teXPreview : ->
    try
      output = teXifyAM @input()
    catch error
      output = "error"
    output

  nerdamerOutputAM : ->
    try
      output = nerdamer(@input()).text "fractions"
    catch error
      output = "error"
    output

  nerdamerOutputTeX : ->
    teXifyAM @nerdamerOutputAM()
