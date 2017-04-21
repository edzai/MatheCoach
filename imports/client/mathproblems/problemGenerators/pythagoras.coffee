{ Rnd } = require "../randomGenerators.coffee"
rnd = new Rnd()

{ Check } = require "../checks.coffee"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

{ Point } = require "/imports/client/geoDraw.coffee"

# require "./templates/templateTestTemplate/templateTestTemplate.coffee"
require "./templates/pythagorasTemplate/pythagorasTemplate.coffee"

generators =
  calculateHypothenuse : (level = 1) ->
    [la, lb] = rnd.intsMin 80, 140
    phi = rnd.intMin 0, 359
    unit = "cm"
    #returns
    problem : "not used"
    solution : ((la**2 + lb**2)**.5).toFixed 1
    description : "Satz des Pythagoras"
    customTemplateName : "pythagorasTemplate"
    customTemplateData : { la, lb, unit , phi }

exports.templateTest =
  title : "Test: Graphik in Custom Blaze Templates"
  description : "Test für Graphiken in Aufgaben"
  problems : [
    levels : [1]
    generator : generators.calculateHypothenuse
  ]
