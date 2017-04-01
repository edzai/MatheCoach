require "./raphaelTestTemplate.jade"
{ GeoDraw, Point } = require "/imports/client/geoDraw.coffee"

Template.raphaelTestTemplate.viewmodel
  unit : "cm"
  geoDraw : {}
  autorun : ->
    @geoDraw().clear()
    lineArray = [
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
    lineArray.forEach (e) =>
      e.startPoint
        .translate(new Point 100-@lb()/2, 100-@la()/2)
        .rotate @phi(), (new Point 100, 100)
    @geoDraw().labeledPolygon lineArray
  onRendered : ->
    @geoDraw new GeoDraw "drawing", 200, 200
