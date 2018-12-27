<template lang="pug">
.item
  .content-box.separated
    p.text {{timeAgo}}:
    display-problem(v-bind:problem="submission")
  .content-box.answer-line
    .text {{submission.answer || "[Keine Antwort]"}}
    Icon.answer-icon(v-if="submission.answerCorrect" type="md-checkmark" color="#19be6b" size=20)
    Icon.answer-icon(v-else type="md-close" color="#ed3f14" size=20)
</template>

<script lang="coffee">
import DisplayProblem from "./DisplayProblem.vue"
export default
  computed :
    timeAgo : ->
      @$store.state.tickle.tick
      moment(@submission.date).fromNow()
  props :
    submission :
      type : Object
      required : true
  components : {DisplayProblem}
</script>

<style scoped lang="sass">
.item
  flex-shrink: 1
.answer-icon
  margin-left : 20px
.answer-line
  display: flex
  justify-content: center
  align-items: center
  margin-bottom: 20px
</style>
