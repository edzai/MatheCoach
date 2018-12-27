<template lang="pug">
.content-box
  h1.heading Eingabe von Mathematischen Formeln und Termen
  p.text Die Eingabe von Mathematischen Formeln und Termen mit MatheCoach ist ganz einfach.
  p.text Für Dezimalbrüche wird nicht das Komma sondern der Punkt verwendet. Das Komma wird verwendet, um bei Aufgaben mit mehreren Lösungen die Lösungen voneinander zu trennen.
  p.text Es gibt einige Fälle, bei denen es besonders darauf ankommt, Klammern zu setzen. Welchen Unterschied Klammern machen, könnt ihr den Beispielen entnehmen:
  table
    tr
      th Input
      th Output
    tr(v-for="input in inputs" v-bind:key="input")
      td {{input}}
      td: katex(v-bind:tex="tex(input)")
</template>

<script lang="coffee">
import Katex from "./Katex.vue"
import { teXifyAM } from "/imports/client/mathproblems/renderAM.coffee"
export default
  data : ->
    inputs : [
      "1+1"
      "a+2b"
      "2a/(3b)"
      "2a/3b"
      "2^3"
      "a^(3b)"
      "a^3b"
      "sqrt(2)"
      "sqrt(2a/(3b + 4))"
      "sin(3pi)"
      "a=2/3, b=3.2"
    ]
  methods :
    tex : teXifyAM
  components : { Katex }
</script>

<style scoped lang="sass">
table
  width : 100%
  margin: 20px auto 10px
  border-spacing: 0
  border: 1pt solid #e9eaec
  // box-shadow: 3px 3px 3px silver
th
  padding: 8px
  background-color: #e9eaec
td
  padding: 8pt
  text-align: center
  border-top: 1pt solid #e9eaec
</style>
