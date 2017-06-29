{ problemDefinitions, modules, moduleKeys } = require "./problemDefinitions.coffee"

buildModulesList = (modules) ->
  (
    for module in modules
      if typeof module is "string"
        moduleKey : module
        title : problemDefinitions[module].title
        description : problemDefinitions[module].description
      else
        title : module.title
        description : module.description
        kindred : buildModulesList(module.kindred)
  )

exports.getModulesList = -> buildModulesList modules

exports.getModuleTitle = (key) -> problemDefinitions[key].title

exports.moduleFilterList = moduleKeys.map (key) ->
  key : key
  title : exports.getModuleTitle key
