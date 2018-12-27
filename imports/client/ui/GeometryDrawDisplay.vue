<template lang="pug">
svg(ref="svg" width="50%" preserveAspectRatio="xMidYMid meet")
</template>

<script lang="coffee">
import { GeometryDraw } from "/imports/client/mathproblems/geometryDraw.coffee"
export default
  data : ->
    drawing : {}
  methods :
    draw : ->
      @drawing = new GeometryDraw @$refs.svg
      @drawing.draw @data
  mounted : -> @draw()
  watch :
    data : ->
      @drawing.paper?.clear()
      @draw()
  props : ["data"]
</script>

<style scoped lang="sass">
</style>
