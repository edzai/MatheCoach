<template lang="jade">
div
  submission-list-item(v-for="submission in submissions" v-bind:key="submission._id" v-bind:submission="submission")
  .content-box.center.separated(v-if="!$subReady.userSubmissions")
    .spin-container
      Spin(size=large fix)
    p Loading

  Button(@click="page +=1") Mehr
</template>

<script lang="coffee">
import SubmissionListItem from "./SubmissionListItem.vue"
return
  data : ->
    page : 1
    submissions : []
  methods :
    handleReachBottom : ->
  meteor :
    $subscribe :
      userSubmissions : -> [userId : @user._id, page : @page]
    submissions :
      params : ->
        user : @user
        page : @page
      update : ({ user, page }) -> user?.submissionsPage?(page)
  props :
    user :
      type : Object
      required : true
  components : { SubmissionListItem }
</script>

<style scoped lang="sass">
</style>
