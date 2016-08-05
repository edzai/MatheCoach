{ Fraction, Expression, Equation } = algebra = require "algebra.js"
require "/imports/modules/ASCIIMathTeXImg.js"
nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Algebra.js"
require "/imports/modules/nerdamer/Calculus.js"

katex = require "katex"
require "katex/dist/katex.min.css"
require "./outputtest.jade"

Template.outputtest.viewmodel
  str : "(x+1)/(x-1)"
  expr : -> algebra.parse @str()
  outputRaw : ->
    texStr = AMTparseAMtoTeX @str()
    katex.renderToString texStr,
      displayMode : true
      throwOnError : false
  output : ->
    try
      texStr =algebra.toTex @expr()
    catch err
      texStr = "undefined: #{err}"
    katex.renderToString texStr,
      displayMode : true
      throwOnError : false
  output2 : ->
    try
      nerdamer @str(), undefined
      expressions = nerdamer.expressions(false, true)
      console.log expressions
      texStr = expressions[-1..][0]
    catch
      expression = "undefined expression"
    katex.renderToString texStr,
      displayMode : true
      throwOnError : false
