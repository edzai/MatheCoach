<template lang="jade">
.content-box.separated
  .flex
    .left
      info-avatar.avatar(
        v-bind:user="user"
        v-bind:size="32"
      )
      .middle
        h1.heading {{user.fullName()}} ({{user.username}})
        p.text {{timeAgo}}
    .right
      Button(
        type="error"
        shape="circle"
        icon="trash-a"
        @click="deleteUser"
        style="margin-right : 8px"
      )
      Button(
        v-bind:type="editing ? 'ghost' : 'primary'"
        shape="circle"
        icon="edit"
        @click="editUser"
      )
</template>

<script lang="coffee">
import UserPersonalSettings from "./UserPersonalSettings.vue"
import UserSchoolClassSettings from "./UserSchoolClassSettings.vue"
import InfoAvatar from "./InfoAvatar.vue"
return
  data : ->
    editing : false
  computed :
    timeAgo : ->
      if @user.lastActive then moment(@user.lastActive).fromNow() else ""
  methods :
    deleteUser : -> @$Message.info "deleteUser"
    editUser : ->
      @$router.push
        name : "adminUserSettingsPage"
        params :
          id : @user._id
  props :
    user :
      type : Object
      required : true
  components : { UserPersonalSettings, UserSchoolClassSettings, InfoAvatar}
</script>

<style scoped lang="sass">
.flex
  display: flex
  justify-content: space-between
  align-items: center
.left
  flex-grow : 1
  flex-shrink : 1
  display: flex
  align-items : center
.avatar
  flex-shrink : 0
.middle
  margin-left : 20px
.right
  flex-grow : 0
  flex-shrink: 0
</style>
