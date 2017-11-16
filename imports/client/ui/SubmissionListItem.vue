<template lang="jade">
div
  .content-box
    p.text {{timeAgo}}:
    display-problem(v-bind:problem="submission")
  .content-box.answer-line.separated
    .text {{submission.answer || "[Keine Antwort]"}}
    Icon.answer-icon(v-if="submission.answerCorrect" type="checkmark" color="#19be6b" size=20)
    Icon.answer-icon(v-else type="close" color="#ed3f14" size=20)

</template>

<script lang="coffee">
import DisplayProblem from "./DisplayProblem.vue"
return
  computed :
    timeAgo : -> moment(@submission.date).fromNow()
  props :
    submission :
      type : Object
      required : true
  components : {DisplayProblem}
</script>

<style scoped lang="sass">
.separated
  margin-bottom : 30px
.separated2
  margin-bottom : 3px
.answer-icon
  margin-left : 20px
.answer-line
  margin-top : 10px
  display: flex
  justify-content: center
  align-items: center
</style>
