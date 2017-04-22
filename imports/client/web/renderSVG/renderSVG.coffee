require "./renderSVG.jade"
{ GeometryDraw } = require "/imports/client/geometryDraw.coffee"

Template.renderSVG.viewmodel
  drawing : {}
  SVGId : ""
  geometryDrawData : {}
  # width : 200
  # height : 200
  initDrawing : ->

  onRendered : ->
    unless @drawing().paper?
      @drawing(new GeometryDraw @SVGId())
      @drawing().draw @geometryDrawData()

  autorun : ->
    if @drawing().paper?
      @drawing().paper.clear()
      @drawing().draw @geometryDrawData()
