katex = require "katex"
require "katex/dist/katex.min.css"
math = require "mathjs"

#use mathjs to get rid of redundant parentheses
exports.teXifyAM = teXifyAM = (str) ->
  unless "=" in str.split ""
    node = math.parse str
    node.toTex
      parenthesis : "auto"
      implicit : "hide"
  else
    (teXifyAM part for part in str.split "=").join "="

exports.renderTeX = renderTeX = (str) ->
  katex.renderToString str,
    displayMode : true
    throwOnError : false

exports.renderAM = (str) ->
  renderTeX teXifyAM(str)
