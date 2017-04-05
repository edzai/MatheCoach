require "./polygonSVG.jade"
{ GeoDraw, Point } = require "/imports/client/geoDraw.coffee"

Template.polygonSVG.viewmodel
  paper : {}
  onRendered : ->
    @paper(new GeoDraw @componentId(), 200, 200)
  autorun : ->
    @paper().clear()
    @paper().labeledPolygon @polygonLineArray()
