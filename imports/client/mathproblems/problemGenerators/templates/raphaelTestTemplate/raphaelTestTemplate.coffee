require "./raphaelTestTemplate.jade"
{ Random } = require "meteor/random"
{ Point } = require "/imports/client/geoDraw.coffee"
require "../polygonSVG/polygonSVG.coffee"

Template.raphaelTestTemplate.viewmodel
  svgData : ->
    componentId = Random.id()
    polygonLineArray = [
        startPoint : new Point 0, 0
        pointLabelText : "B"
        angleLabelText : "β"
        lineLabelText : "a = #{@la()}#{@unit()}"
      ,
        startPoint : new Point 0, @la()
        pointLabelText : "C"
        angleLabelText : "ɣ"
        lineLabelText : "b = #{@lb()}#{@unit()}"
      ,
        startPoint : new Point @lb(), @la()
        pointLabelText : "A"
        angleLabelText : "α"
        lineLabelText : "c = ?"
      ]
    polygonLineArray.forEach (e) =>
      e.startPoint
        .translate(new Point 100-@lb()/2, 100-@la()/2)
        .rotate @phi(), (new Point 100, 100)
    { componentId, polygonLineArray }
