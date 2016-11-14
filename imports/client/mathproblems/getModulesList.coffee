{ problemDefinitions, modules } = require "./problemDefinitions.coffee"

exports.getModulesList = ->
  result = []
  for module in modules
    result.push
      key : module
      title : problemDefinitions[module].title
      description : problemDefinitions[module].description
  result

exports.getModuleTitle = (key) ->
  problemDefinitions[key].title
