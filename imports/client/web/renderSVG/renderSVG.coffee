require "./renderSVG.jade"
{ GeometryDraw } = require "/imports/client/geometryDraw.coffee"

Template.renderSVG.viewmodel
  drawing : {}
  SVGId : ""
  geometryDrawData : {}
  # width : 200
  # height : 200
  onRendered : ->
    @drawing(new GeometryDraw @SVGId())
    @drawing().draw @geometryDrawData()
  autorun : ->
    if @drawing.value.paper?
      @drawing.value.paper.clear()
    @drawing(new GeometryDraw @SVGId())
    @drawing.value.draw @geometryDrawData()
