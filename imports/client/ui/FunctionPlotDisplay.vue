<template lang="jade">
div
  svg(
    width="100%"
    height="100%"
    v-bind:viewBox="viewBox"
    v-bind:title="data"
  )
    //- grid
    g(v-for="tickX in ticksX")
      circle.grid(v-for="tickY in ticksY"
        v-bind:cx="tickX * scale + origin.x"
        v-bind:cy="-tickY * scale + origin.y"
        r=4
      )
    //- y-axis
    line.axis(
      v-bind:x1="origin.x"
      y1="0"
      v-bind:x2="origin.x"
      v-bind:y2="height"
    )
    path(d="M 0,0 l 13, 20 l -26, 0" v-bind:transform="arrowYTransform")
    text.axis-label(
      v-bind:x="origin.x"
      y=0
      dx=30
      dy=30
      font-family="mono"
      font-size=50
      ) {{data.yAxis.label}}
    g(v-for="tick in ticksY")
      circle(
        v-bind:cx="origin.x"
        v-bind:cy="- tick * scale + origin.y"
        r=7
      )
      text.tick-text(
        v-bind:y="- tick * scale + origin.y"
        v-bind:x="origin.x"
        v-bind:text-anchor="tick < 0 ? 'start' : 'end'"
        v-bind:dx="tick < 0 ? 20 : -20"
        dy=11
        font-family="mono"
        font-size=50
      ) {{tick === 0 ? "" : tick}}
    //- x-axis
    line.axis(
      x1="0"
      v-bind:y1="origin.y"
      v-bind:x2="width"
      v-bind:y2="origin.y"
    )
    path(d="M 0,0 l 13, 20 l -26, 0" v-bind:transform="arrowXTransform")
    text.axis-label(
      v-bind:x="width"
      v-bind:y="origin.y"
      dx=0
      dy=50
      text-anchor="end"
      font-family="mono"
      font-size=50
      ) {{data.xAxis.label}}
    g(v-for="tick in ticksX")
      circle(
        v-bind:cx="tick * scale + origin.x"
        v-bind:cy="origin.y"
        r="7"
      )
      text.tick-text(
        v-bind:x="tick * scale + origin.x"
        v-bind:y="origin.y"
        text-anchor="middle"
        v-bind:dy="tick > 0 ? -20 : 60"
        font-family="mono"
        font-size=50
      ) {{tick === 0 ? "" : tick}}
    path.plot(
      v-bind:d="functionPath"
      v-bind:transform="functionPathTransform"
    )

</template>

<script lang="coffee">
#DOING: Implement FunctionPlotDisplay
import { Random } from "meteor/random"
import math from "mathjs"
return
  data : ->
    arrowLength : .7
    scale : 100
    margin : 30
  computed :
    functionPath : ->
      fktStr = @data.data?[0]?.fn
      xMin = @data.xAxis.domain[0]
      xMax = @data.xAxis.domain[1]
      result = "M#{xMin*@scale},#{-math.eval(fktStr, {x:xMin})*@scale}"
      for x in [xMin..xMax] by .01
        result += "L#{x*@scale},#{-math.eval(fktStr, {x})*@scale}"
      result
    functionPathTransform : -> "translate(#{@origin.x},#{@origin.y})"
    arrowYTransform : -> "translate(#{@origin.x} -5)"
    arrowXTransform : -> "translate(#{@width+5} #{@origin.y}) rotate(90)"
    viewBox : -> "#{-@margin} #{-@margin} #{@width+2*@margin} #{@height+2*@margin}"
    width : -> @scale * (@range(@data.xAxis.domain) + @arrowLength)
    height : -> @scale * (@range(@data.yAxis.domain) + @arrowLength)
    xMin : -> math.floor @data.xAxis.domain[0]
    xMax : -> math.ceil @data.xAxis.domain[1]
    yMin : -> math.floor @data.yAxis.domain[0]
    yMax : -> math.ceil @data.yAxis.domain[1]
    ticksX : -> [@xMin..@xMax]
    ticksY : -> [@yMin..@yMax]
    origin : ->
      x : -@xMin * @scale
      y : (@yMax + @arrowLength) * @scale
  methods :
    range : (domain) -> math.floor(domain[1])-math.ceil(domain[0])

  props : ["data"]
</script>

<style scoped lang="sass">
.grid
  fill : #DDD
.axis
  stroke-width: 6
  stroke: #333
.plot
  stroke-width: 7
  stroke: #111
  fill: none
.tick-text
  fill: #333
  font-weight: 100
.axis-label
  fill: #333
  font-weight: 100
  font-size: 100
</style>
