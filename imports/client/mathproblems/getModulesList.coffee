{ problemDefinitions, modules, moduleKeys } = require "./problemDefinitions.coffee"

buildModulesList = (modules, language="de") ->
  (
    for module in modules
      if typeof module is "string"
        moduleKey : module
        title :
          problemDefinitions[module]?.title?[language] ?
          problemDefinitions[module]?.title?.de
        description :
          problemDefinitions[module]?.description?[language] ?
          problemDefinitions[module]?.description?.de
      else
        title :
          module.title?[language] ?
          module.title?.de
        description :
          module.description?[language] ?
          module.description?.de
        kindred : buildModulesList(module.kindred, language)
  )

exports.getModulesList = (language="de") -> buildModulesList modules, language

exports.getModuleTitle = (key, language="de") ->
  problemDefinitions[key].title[language] ?
  problemDefinitions[key].title.de

exports.moduleFilterList = (language="de") ->
  moduleKeys.map (key) ->
    key : key
    title :
      (exports.getModuleTitle key, language) ?
      exports.getModuleTitle key, "de"
