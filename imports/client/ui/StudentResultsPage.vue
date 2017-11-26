<template lang="jade">
.content-no-box(v-if="student")
  .plot
    user-bar-plot(v-bind:user="student")
  h1.heading(v-if="ownPage") {{$t('meineErgebnisse')}}:
  h1.heading(v-else) {{$t('ergebnisseVon')}} {{student.fullName()}} ({{student.username}}):
  submission-list(v-bind:submissions="submissions")

</template>

<script lang="coffee">
import { Submissions } from "/imports/api/submissions.coffee"
import SubmissionList from "./SubmissionList.vue"
import UserBarPlot from "./UserBarPlot.vue"
return
  data : ->
    submissions : []
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
  components : { SubmissionList, UserBarPlot }
</script>

<style scoped lang="sass">
.plot
  height : 200px
  overflow: hidden
  box-shadow: 1px 1px 2px silver
  border-radius: 5px
  margin-bottom: 20px
</style>
