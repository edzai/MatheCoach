<template lang="jade">
div
  submission-list-item(v-for="submission in submissions" v-bind:key="submission._id" v-bind:submission="submission")
</template>

<script lang="coffee">
import SubmissionListItem from "./SubmissionListItem.vue"
return
  props :
    submissions :
      type : Array
      required : true
  components : { SubmissionListItem }
</script>

<style scoped lang="sass">
</style>
