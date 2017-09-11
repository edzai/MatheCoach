require "./renderSVG.jade"
{ GeometryDraw } = require "/imports/client/mathproblems/geometryDraw.coffee"

Template.renderSVG.viewmodel
  debug : false
  style : ->
    unless @debug()
      ""
    else
      "border : 1px solid pink"
  drawing : {}
  SVGId : ""
  geometryDrawData : {}
  # width : 200
  # height : 200
  onRendered : ->
    console.log @data()
    @drawing(new GeometryDraw @SVGId())
    @drawing().draw @geometryDrawData()
  autorun : ->
    if @drawing.value.paper?
      @drawing.value.paper.clear()
    @drawing(new GeometryDraw @SVGId())
    @drawing.value.draw @geometryDrawData()
