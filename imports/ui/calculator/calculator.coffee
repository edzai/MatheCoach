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

  teXFromInput : ->
    try
      output = teXifyAM @input()
    catch error
      output = ""
    output

  teXPreview : ->
    try
      output = renderAM @input()
    catch error
      output = "error"
    output

  nerdamerOutputHtml : ->
    output = "kein Output"
    try
      output = nerdamer(@input()).toTeX()
    catch error
      output = "error"
    renderTeX output

  algebrajsOutputHtml : ->
    try
      exp = new algebra.parse @input()
      output = exp.toString()
    catch error
      output = "error"
    renderAM output

  nerdamerOutputAM : ->
    try
      output = nerdamer(@input()).text "fractions"
    catch error
      output = "error"
    output

  algebrajsOutputAM : ->
    try
      exp = new algebra.parse @input()
      output = exp.toString()
    catch error
      output = "error"
    output
