<template lang="jade">
.content-no-box
  h1.heading Meine Ergebnisse:
  div(v-for="submission in submissions")
    submission-list-item(v-bind:submission="submission")
</template>

<script lang="coffee">
import { Submissions } from "/imports/api/submissions.coffee"
import SubmissionListItem from "./SubmissionListItem.vue"
return
  data : -> {}
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
  components : { SubmissionListItem }
</script>

<style scoped lang="sass">
</style>
