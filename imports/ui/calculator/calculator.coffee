#require "/imports/ui/mathJax/mathJax.coffee"
require "./calculator.jade"

_ = require "lodash"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

algebra = require "algebra.js"

math = require "mathjs"

{ renderAM, renderTeX, teXifyAM } =
  require "/imports/modules/mathproblems2/renderAM.coffee"

{ AMString } =
  require "/imports/modules/mathproblems2/AMString.coffee"

Template.calculator.viewmodel
  input : ""

  teXPreview : ->
    try
      output = teXifyAM @input()
    catch error
      output = "error"
    output

  amString : ->
    try
      output = new AMString(@input())
        .markReserved()
        .removeWhitespace()
        .productify()
        .unmarkReserved()
        .value()
    catch error
      console.log error
      output = "error"
    output

  nerdamerProcessedTeX : ->
    try
      nerdamerOutput = nerdamer(@amString()).text "fractions"
      output = new AMString(nerdamerOutput).unproductify().value()
      console.log "nerdamer", nerdamerOutput
      console.log "AMString", output
    catch error
      output = "error"
    teXifyAM output


  nerdamerRawTeX : ->
    try
      output = nerdamer(@amString()).toTeX()
    catch error
      output = "error"
    output
