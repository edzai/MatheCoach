{ Rnd } = require "../randomGenerators.coffee"
rnd = new Rnd()

{ Check } = require "../checks.coffee"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

require "./templates/templateTestTemplate/templateTestTemplate.coffee"

generators =
  oneGenerator : (level = 1) ->
    [la, lb] = rnd.intsMin 60, 175
    unit = "cm"
    #returns
    problem : "not used"
    solution : ((la**2 + lb**2)**.5).toFixed 1
    description : "Satz des Pythagoras"
    customTemplateName : "templateTestOneGeneratorTemplate"
    customTemplateData : { la, lb, unit }

exports.templateTest =
  title : "Test: Custom Blaze Templates in Aufgaben"
  description : "Dies ist lediglich ein Test und nicht als Übungsmodul
    für Schüler gedacht"
  problems : [
    levels : [1]
    generator : generators.oneGenerator
  ]
