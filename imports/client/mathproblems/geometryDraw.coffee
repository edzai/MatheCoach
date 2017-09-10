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
    (180+(fulcrum.angle p)-(@angle fulcrum))%%360

  rotate : (phi, fulcrum = (new Point 0, 0)) ->
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
        @normal = new Point 0, if p1.x > p2.x then 1 else -1
    else
      @isVertical = true
      @normal = new Point 1, 0
    #make the normal always point right looking from p1 to p2
    @normal = @normal.multiply(-1) if @p1.y < @p2.y
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

exports.umkreis = (p1, p2, p3) ->
  d=2*(p1.x*(p2.y-p3.y)+p2.x*(p3.y-p1.y)+p3.x*(p1.y-p2.y))
  xu=((p1.x**2+p1.y**2)*(p2.y-p3.y)+(p2.x**2+p2.y**2)*(p3.y-p1.y)+
    (p3.x**2+p3.y**2)*(p1.y-p2.y))/d
  yu=((p1.x**2+p1.y**2)*(p3.x-p2.x)+(p2.x**2+p2.y**2)*(p1.x-p3.x)+
    (p3.x**2+p3.y**2)*(p2.x-p1.x))/d
  center = new Point xu, yu
  radius = center.distance p1
  {center, radius}

class GeometryDraw
  constructor : (svg) ->
    if typeof svg is "string"
      @paper = Snap "##{svg}"
    else
      @paper = Snap svg
    @g = @paper.g()

  lineLabel : (p1, p2, labelText, onLine=false) ->
    unless labelText is "" or labelText is undefined
      mid = p1.add(p2).multiply(.5)
      yOffset = unless onLine then -3 else +3
      angle = p1.angle(p2)
      if 90< angle < 270
        angle += 180
        yOffset = unless onLine then 10.5 else 4
      text = @paper
        .text(mid.x, mid.y, labelText)
        .attr
          "text-anchor": "middle"
          "font-size" : 11
          transform : "translate(0 #{yOffset})"
      textBBox = text.getBBox()
      textBox = @paper
        .rect textBBox.x, textBBox.y, textBBox.width, textBBox.height
        .attr fill : if onLine then "white" else "none"
      labelGroup = @paper.g textBox
      labelGroup.add text
      labelGroup.attr
        transform : "rotate(#{angle} #{mid.x} #{mid.y})"
      @g.add labelGroup
      { text, textBox }

  labeledLine : (p1, p2, text, labelOnLine=false) ->
    line = @paper
      .line p1.x, p1.y, p2.x, p2.y
      .attr
        stroke : "black"
        strokeWidth : 1
    @g.add line
    lineLabel = @lineLabel p1, p2, text, labelOnLine
    { line, lineLabel }

  labeledPoint : (p, labelText, labelOffset, drawMark = true) ->
    if drawMark
      mark = @paper
        .circle p.x, p.y, 3
    labelOffset ?= (new Point 12, 0).rotate(45).add(new Point 0, 4)
    labelTextAnchor = p.add labelOffset
    if labelText? and labelText isnt ""
      pointLabel = @paper
        .text labelTextAnchor.x, labelTextAnchor.y, labelText
        .attr "font-size" : 14, "text-anchor" : "middle"
      @g.add pointLabel

  labeledAngle : (p1, p2, fulcrum, pointLabelText, angleLabelText) ->
    radius = 40
    angle = p1.angle p2, fulcrum
    innerAngle = Math.round(p1.innerAngle p2, fulcrum)
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

  lineMeasure : (lStart, lEnd, text, level=1) ->
    levelHeight = 25
    levelOffset = 4
    line = new Line lStart, lEnd
    [start, end] = [lStart, lEnd].map (p) =>
      p1 = p.add line.normal.multiply levelOffset
      p2 = p.add line.normal.multiply level*levelHeight
      helperLine = @paper
        .line p1.x, p1.y, p2.x, p2.y
        .attr
          stroke : "grey"
          strokeWidth : 1
      @g.add helperLine
      #return
      line : helperLine
      levelPoint :
        p.add line.normal.multiply level*levelHeight-levelOffset
    labeledLine = @labeledLine start.levelPoint, end.levelPoint, text, true
    labeledLine.line.attr stroke : "grey"
    #labeledLine.lineLabel.text.attr stroke : "pink"

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
      if line.lineLabelInside
        @labeledLine nextLine.startPoint, line.startPoint,
          line.lineLabelText
      else
        @labeledLine line.startPoint, nextLine.startPoint,
          line.lineLabelText
      @labeledAngle prevLine.startPoint, nextLine.startPoint,
        line.startPoint, line.pointLabelText, line.angleLabelText
      if line.measureText?
        if line.measureInside
          @lineMeasure nextLine.startPoint, line.startPoint,
            line.measureText, line.measureLevel
        else
          @lineMeasure line.startPoint, nextLine.startPoint,
            line.measureText, line.measureLevel

  labeledCircle :
    (center, radius, phi = -45
    drawCenter = true, drawRadius = false
    centerLabelText, radiusLabelText) ->
      circle = @paper
        .circle center.x, center.y, radius
        .attr
          stroke : "black"
          strokeWidth : 1
          fill : "none"
      if drawCenter or centerLabelText?
        if drawRadius
          centerLabelTextOffset =
            (new Point 12, 0).rotate(phi+180).add(new Point 0, 4)
        @labeledPoint center, centerLabelText, centerLabelTextOffset
      if drawRadius
        radiusEndPoint =
          new Point radius, 0
          .rotate phi
          .add center
        @labeledLine center, radiusEndPoint, radiusLabelText


  draw : (dataArray) ->
    for e in dataArray
      switch e.type
        when "polygon"
          for line in e.lines
            line.startPoint = new Point line.startPoint
          @labeledPolygon e.lines
        when "normal"
          for key in ["startPoint", "endPoint", "p"]
            e.line[key] = new Point e.line[key]
          @normal e.line.startPoint, e.line.endPoint, e.line.p, e.line.text
        when "measurement"
          for key in ["startPoint", "endPoint"]
            e.line[key] = new Point e.line[key]
          @lineMeasure e.line.startPoint, e.line.endPoint, e.line.text
        when "circle"
          e.center = new Point e.center
          @labeledCircle e.center, e.radius, e.phi,
            e.drawCenter, e. drawRadius,
            e.centerLabelText, e.radiusLabelText,
            e.radiusEndLabelText
        else console.log "unknown type of geometryDraw object"
    bounds = @g.getBBox()
    @paper.attr viewBox : bounds.vb

exports.GeometryDraw = GeometryDraw
