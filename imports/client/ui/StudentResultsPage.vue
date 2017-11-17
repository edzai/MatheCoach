<template lang="jade">
.content-no-box(v-if="student")
  h1.heading(v-if="ownPage") {{$t('meineErgebnisse')}}:
  h1.heading(v-else) {{$t('ergebnisseVon')}} {{student.fullName()}} ({{student.username}}):
  submission-list(v-bind:submissions="submissions")

</template>

<script lang="coffee">
import { Submissions } from "/imports/api/submissions.coffee"
import SubmissionList from "./SubmissionList.vue"
return
  data : ->
    submissions : {}
    student : {}
  computed :
    ownPage : -> @$route?.name is "studentOwnResultsPage"
    studentId : ->
      if @ownPage then @$store?.state?.auth?.user?._id else @$route?.params?.id
  meteor :
    submissions :
      params : -> userId : @studentId
      update : ({ userId }) ->
        Submissions.find { userId },
          sort :
            date : -1
        .fetch()
    student :
      params : -> studentId : @studentId
      update : ({ studentId }) -> Meteor.users.findOne _id : studentId
  components : { SubmissionList }
</script>

<style scoped lang="sass">
</style>
