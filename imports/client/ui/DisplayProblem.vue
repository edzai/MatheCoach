<template lang="jade">
div
  span.heading {{problem.title}},
  span.sub.heading Level {{problem.level}}
  p.text {{problem.description}}
  katex(v-if="!problem.skipExpression" v-bind:tex="problem.problemTeX")
  .center
    geometry-draw-display(v-if="drawSVG" v-bind:data="problem.geometryDrawData")
    function-plot(v-if="drawFunctionPlot" v-bind:data="problem.functionPlotData")
  span(v-if="problem.hint") {{problem.hint}}
</template>

<script lang="coffee">
import Katex from "/imports/client/ui/Katex.vue"
import GeometryDrawDisplay from "/imports/client/ui/GeometryDrawDisplay.vue"
import FunctionPlot from "/imports/client/ui/VueFunctionPlot/FunctionPlot.vue"
return
  computed :
    drawSVG : -> @problem?.geometryDrawData?
    drawFunctionPlot : -> @problem?.functionPlotData?
  props :
    problem :
      type : Object
      required : true
  components : { Katex, GeometryDrawDisplay, FunctionPlot }
</script>

<style scoped lang="sass">
.center
  text-align : center
</style>
