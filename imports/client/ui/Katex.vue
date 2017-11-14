<template lang="jade">
div(v-html="html")
</template>

<script lang="coffee">
import katex from "katex"
return
  computed :
    html : ->
      if typeof @tex is "string"
        katex.renderToString @tex, @options
  props :
    tex : String
    options :
      type : Object
      default : ->
        displayMode : true
        throwOnError : false
</script>

<style scoped lang="sass">
</style>
