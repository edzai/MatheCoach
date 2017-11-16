<template lang="jade">
.content-no-box
  h1.heading Meine Ergebnisse:
  submission-list(v-bind:submissions="submissions")

</template>

<script lang="coffee">
import { Submissions } from "/imports/api/submissions.coffee"
import SubmissionList from "./SubmissionList.vue"
return
  data : ->
    submissions : {}
  computed :
    studentId : -> @$store?.state?.auth?.user?._id
  meteor :
    submissions :
      params : -> userId : @studentId
      update : ({ userId }) ->
        Submissions.find { userId },
          sort :
            date : -1
        .fetch()
  components : { SubmissionList }
</script>

<style scoped lang="sass">
</style>
