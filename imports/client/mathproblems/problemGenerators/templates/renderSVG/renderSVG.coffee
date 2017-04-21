require "./renderSVG.jade"
{ GeometryDraw } = require "/imports/client/geometryDraw.coffee"

Template.renderSVG.viewmodel
  drawing : {}
  componentId : ""
  width : 200
  height : 200
  initDrawing : ->

  onRendered : ->
    unless @drawing().paper?
      @drawing(new GeometryDraw @componentId())
      @drawing().labeledPolygon @polygonLineArray()

  autorun : ->
    if @drawing().paper?
      @drawing().paper.clear()
      @drawing().labeledPolygon @polygonLineArray()
