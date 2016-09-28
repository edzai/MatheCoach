math = require "mathjs"

#use mathjs to get rid of redundant parentheses
exports.teXifyAM = teXifyAM = (str = "") ->
  unless "," in str.split ""
    unless "=" in str.split ""
      node = math.parse str
      node.toTex
        parenthesis : "auto"
        implicit : "hide"
    else
      (teXifyAM part for part in str.split "=").join "="
  else
    (teXifyAM part for part in str.split ",").join ","
