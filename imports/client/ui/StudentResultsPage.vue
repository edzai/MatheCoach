<template lang="jade">
.content-no-box(v-if="user")
  .plot
    user-bar-plot(v-bind:user="user")
  h1.heading(v-if="ownPage") {{$t('meineErgebnisse')}}:
  h1.heading(v-else) {{$t('ergebnisseVon')}} {{user.fullName()}} ({{user.username}}):
  submission-list(v-bind:user="user")

</template>

<script lang="coffee">
import { Submissions } from "/imports/api/submissions.coffee"
import SubmissionList from "./SubmissionList.vue"
import UserBarPlot from "./UserBarPlot/UserBarPlot.vue"
return
  data : ->
    user : {}
  computed :
    ownPage : -> @$route?.name is "studentOwnResultsPage"
    userId : ->
      if @ownPage then @$store?.state?.auth?.user?._id else @$route?.params?.id
  meteor :
    $subscribe :
      userData : -> [id : @userId]
    user :
      params : -> userId : @userId
      update : ({ userId }) -> Meteor.users.findOne _id : userId
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
