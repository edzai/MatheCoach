require "./svgTestTemplate.jade"
{ Random } = require "meteor/random"
{ Point } = require "/imports/client/mathproblems/geometryDraw.coffee"
require "/imports/client/web/renderSVG/renderSVG.coffee"

Template.svgTestTemplate.viewmodel
  svgData : ->
    componentId = "a#{Random.id()}"
    polygonLineArray = [
        startPoint : new Point 0, 0
        pointLabelText : "B"
        # angleLabelText : "β"
        lineLabelText : "a = #{@la()}#{@unit()}"
      ,
        startPoint : new Point 0, @la()
        pointLabelText : "C"
        # angleLabelText : "⋅"
        lineLabelText : "b = #{@lb()}#{@unit()}"
      ,
        startPoint : new Point @lb(), @la()
        pointLabelText : "A"
        # angleLabelText : "α"
        lineLabelText : "c = ?"
      ]
    polygonLineArray.forEach (e) =>
      e.startPoint = e.startPoint
        .add(new Point 100-@lb()/2, 100-@la()/2)
        .rotate @phi(), (new Point 100, 100)
    { componentId, polygonLineArray }
