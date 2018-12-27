<template lang="pug">
.result-container
  h1.heading {{$t('deineAntwort')}}
  .content-box
    katex(v-bind:tex="data.answerTeX")
  h1.heading {{$t('musterlösung')}}
  .content-box
    katex(v-bind:tex="data.solutionTeX")
  h1.heading {{$t('auswertung')}}
  .result-header.pass.back(v-if="data.result.pass") {{$t('ergebnisIstKorrekt')}}
  .result-header.fail.back(v-else) {{$t('ergebnisIstNichtKorrekt')}}
  .list
    .list-item(v-for="text in data.result.passTextsRequired")
      Icon.left(type="md-checkmark" color="#19be6b" size=20)
      span.text {{text}}
    .list-item(v-for="text in data.result.passTextsOptional")
      Icon.left(type="md-checkmark" color="#19be6b" size=20)
      span.text {{text}}
    .list-item(v-for="text in data.result.failTextsRequired")
      Icon.left(type="md-close" color="#ed3f14" size=20)
      span.text {{text}}
    .list-item(v-for="text in data.result.failTextsOptional")
      Icon.left(type="md-close" color="#ff9900" size=20)
      span {{text}}
</template>

<script lang="coffee">
import Katex from "/imports/client/ui/Katex.vue"
export default
  props : ["data"]
  components : { Katex }
</script>

<style scoped lang="sass">
h1
  margin-top: 1rem
.result-header
  font-size : 16px
  font-weight: bold
  color : white
  padding : 10px 16px
.list
  box-sizing: border-box
  margin-bottom: 1rem
.list-item
  display: flex
  align-items: center
  padding : 5px
  background-color : white
  margin-top: 2px
  .left
    padding: 10px
</style>
