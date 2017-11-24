<template lang="jade">
.content-box.separated.flex(@click="goToPage")
  .left
    info-avatar(
      v-bind:user="student"
      v-bind:size="40"
    )
  .right
    h1.heading {{name}}
    p.text {{timeAgo}}
</template>

<script lang="coffee">
import InfoAvatar from "./InfoAvatar.vue"
return
  computed :
    timeAgo : ->
      @$store.state.tickle.tick
      if @student.lastActive then moment(@student.lastActive).fromNow() else ""
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
  components : { InfoAvatar }
</script>

<style scoped lang="sass">
.left
  margin-right: 15px
.flex
  display: flex
  justify-content: flex-start
</style>
