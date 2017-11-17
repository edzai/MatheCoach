<template lang="jade">
.content-box(@click="goToPage")
  h1.heading {{name}}
  p.text {{timeAgo}}
</template>

<script lang="coffee">
return
  computed :
    timeAgo : -> moment(@student.lastActive).fromNow()
    name : ->
      if @student.profile?.firstName? and @student.profile?.lastName?
        "#{@student.profile?.firstName} #{@student.profile?.lastName} (#{@student.username})"
      else
        "(#{@student.username})"
  methods :
    goToPage : -> @$router.push
      name : "studentResultsPage"
      params :
        id : @student._id
  props :
    student :
      type : Object
      required : true
</script>

<style scoped lang="sass">
.red
  color: red
</style>
