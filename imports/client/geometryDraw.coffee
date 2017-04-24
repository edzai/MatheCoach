Snap = require "snapsvg-cjs"

class Point
  constructor : (arg1, arg2) ->
    if typeof arg1 is "number"
      @x = arg1
      @y = arg2
    else
      @x = arg1.x
      @y = arg1.y

  copy : -> new Point @x, @y

  invert : -> new Point -@x, -@y
  add : (p) -> new Point @x+p.x, @y+p.y
  subtract : (p) -> @add p.invert()
  multiply : (r) -> new Point @x*r, @y*r

  length : -> (@x**2 + @y**2)**.5
  distance : (p) -> @subtract(p).length()
  unit : -> @multiply 1/@length()
  toLength : (r) -> @unit().multiply(r)

  angle : (p, fulcrum) ->
    Snap.angle @x, @y, p.x, p.y, fulcrum?.x, fulcrum?.y

  innerAngle : (p, fulcrum) ->
    innerAngle = (Math.round 180+(fulcrum.angle p)-(@angle fulcrum))%%360
    innerAngle
    # if innerAngle > 0 then innerAngle else innerAngle + 360

  rotate : (phi, fulcrum) ->
    matrix = (new Snap.Matrix()).rotate(phi, fulcrum.x, fulcrum.y)
    new Point matrix.x(@x, @y), matrix.y(@x, @y)

exports.Point = Point

class Line
  constructor : (@p1, @p2) ->
    @unit = @p2.subtract(@p1).unit()
    unless @p1.x is @p2.x
      @slope = (@p2.y-@p1.y)/(@p2.x-@p1.x)
      unless @slope is 0
        @normal = (new Point 1, -1/@slope).toLength 1
      else
        @normal = new Point 0, 1
    else
      @isVertical = true
      @normal = new Point 1, 0
    @length = @p1.distance @p2
    @angle = @p1.angle @p2
    @pathString = "M#{@p1.x} #{@p1.y}L#{@p2.x} #{@p2.y}"

  rotate : (phi, fulcrum) ->
    new Line (p1.rotate phi, fulcrum), (p2.rotate phi, fulcrum)

  extend : ->
    p1 = @p1.subtract(@unit.multiply 1000)
    p2 = @p2.add(@unit.multiply 1000)
    new Line p1, p2

  extend1 : (gap = 0, length = 1000) ->
    p2 = @p1.subtract(@unit.multiply gap)
    p1 = p2.subtract(@unit.multiply length-gap)
    new Line p1, p2

  extend2 : (gap = 0, length = 1000) ->
    p1 = @p2.add(@unit.multiply gap)
    p2 = p1.add(@unit.multiply length-gap)
    new Line p1, p2

exports.Line = Line

class GeometryDraw
  constructor : (id) ->
    @paper = Snap "##{id}"
    @g = @paper.g()

  lineLabel : (p1, p2, labelText) ->
    mid = p1.add(p2).multiply(.5)
    yOffset = -3
    angle = p1.angle(p2)
    if 90< angle < 270
      angle += 180
      yOffset = 11
    text = @paper
      .text(mid.x, mid.y, labelText)
      .attr
        "text-anchor": "middle"
        "font-size" : 11
        transform : "translate(0 #{yOffset})"
    labelGroup = @paper.g text
    labelGroup.attr
      transform : "rotate(#{angle} #{mid.x} #{mid.y})"
    @g.add labelGroup
    { text }

  labeledLine : (p1, p2, text) ->
    line = @paper
      .line p1.x, p1.y, p2.x, p2.y
      .attr
        stroke : "black"
        strokeWidth : 1
    lineLabel = @lineLabel p1, p2, text
    @g.add line
    { line, lineLabel }

  labeledAngle : (p1, p2, fulcrum, pointLabelText, angleLabelText) ->
    radius = 30
    angle = p1.angle p2, fulcrum
    innerAngle = p1.innerAngle p2, fulcrum
    angleLabelText ?= "#{innerAngle}°"
    largeArcFlag = if (innerAngle) < 180 then 0 else 1
    arcEndPoint = (p) ->
      p.subtract(fulcrum).toLength(radius).add(fulcrum)
    startPoint = arcEndPoint p1
    endPoint = arcEndPoint p2
    labelOffsetVector =
      startPoint
        .add(endPoint).multiply(.5)
        .subtract(fulcrum)
        .toLength if largeArcFlag then -1 else 1
    adjust = switch
      when innerAngle < 60 then .7
      when innerAngle < 120 then .5 + (120-innerAngle)/60*.2
      else .5
    angleLabelAnchor =fulcrum.add labelOffsetVector.multiply(radius*adjust)
    pointLabelAnchor= fulcrum.subtract labelOffsetVector.multiply(radius*.5)
    unless angleLabelText is ""
      arc = @paper.path "M#{(arcEndPoint p1).x} #{(arcEndPoint p1).y}\
        A #{radius}, #{radius} 0 #{largeArcFlag},1 \
        #{(arcEndPoint p2).x},#{(arcEndPoint p2).y}"
      .attr "stroke" : "#000", "stroke-width" : 1, "fill" : "none"
      angleLabel =  @paper.text  angleLabelAnchor.x, angleLabelAnchor.y+4,
        angleLabelText
      .attr "font-size" : 9, "text-anchor" : "middle"
      @g.add arc, angleLabel
    if pointLabelText?
      pointLabel = @paper.text pointLabelAnchor.x, pointLabelAnchor.y+5,
        pointLabelText
      .attr "font-size" : 14, "text-anchor" : "middle"
      @g.add pointLabel
    { arc, angleLabel, pointLabel }

  normal : (lStart, lEnd, p, text) ->
    line = new Line lStart, lEnd
    normalLine = (new Line p, p.add(line.normal)).extend()
    line1 = line.extend1()
    line2 = line.extend2()
    anchor = (Snap.path.intersection line.pathString, normalLine.pathString)[0]
    if anchor?
      anchorPoint = new Point anchor.x, anchor.y
    else
      anchor = (Snap.path.intersection line1.pathString,
        normalLine.pathString)[0]
      if anchor?
        anchorPoint = new Point anchor.x, anchor.y
        extension = line.extend1 2, lStart.distance(anchorPoint)+4
      else
        line2 = line.extend2()
        anchor = (Snap.path.intersection line2.pathString,
          normalLine.pathString)[0]
        if anchor?
          anchorPoint = new Point anchor.x, anchor.y
          extension = line.extend2 2, lEnd.distance(anchorPoint)+4
        else
          throw new Errow "normal does not intersect with line"
    if extension?
      extensionLine = @paper.line extension.p1.x, extension.p1.y,
        extension.p2.x, extension.p2.y
      extensionLine.attr stroke : "silver"
    labeledLine = @labeledLine anchorPoint, p, text
    { labeledLine }

  labeledPolygon : (lines) ->
    for line, i in lines
      prevLine = if i is 0 then lines[-1..][0] else lines[i-1]
      nextLine = if i < lines.length-1 then lines[i+1] else lines[0]
      @labeledLine line.startPoint, nextLine.startPoint,
        line.lineLabelText
      @labeledAngle prevLine.startPoint, nextLine.startPoint,
        line.startPoint, line.pointLabelText, line.angleLabelText

  draw : (dataArray) ->
    for e in dataArray
      switch e.type
        when "polygon"
          for line in e.lines
            line.startPoint = new Point line.startPoint
          @labeledPolygon e.lines
        when "normals"
          for line in e.lines
            for key in ["startPoint", "endPoint", "p"]
              line[key] = new Point line[key]
            @normal line.startPoint, line.endPoint, line.p, line.text
        else console.log "unknown type of geometryDraw object"
    bounds = @g.getBBox()
    if bounds.x < 0 or bounds.y < 0 or bounds.x2 > 200 or bounds.y2 > 200
      @paper.attr viewBox : bounds.vb
    else
      @paper.attr viewBox : "0 0 200 200"

exports.GeometryDraw = GeometryDraw
