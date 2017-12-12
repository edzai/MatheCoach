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
        p.text {{schoolClassInfo}}
        p.text {{timeAgo}}
    .right
      Button(
        type="warning"
        shape="circle"
        icon="trash-b"
        @click="deleteSubmissions"
        style="margin-right: 8px"
      )
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
#import UserSchoolClassSettings from "./UserSchoolClassSettings.vue"
import InfoAvatar from "./InfoAvatar.vue"
return
  data : ->
    editing : false
  computed :
    timeAgo : ->
      if @user.lastActive then moment(@user.lastActive).fromNow() else ""
    schoolClassInfo : ->
      if name = @user.schoolClass()?.name
        "#{name}, #{@user.teacher()?.fullName()}"
      else ""
  methods :
    deleteUser : ->
      if window.confirm "Den Benutzer wirklich löschen?"
        Meteor.call "deleteUser", id : @user._id
    deleteSubmissions : ->
      if window.confirm "Wirklich alle Ergebnisse für den Benutzer löschen?"
        Meteor.call "deleteSubmissions", userId : @user._id
    editUser : ->
      @$router.push
        name : "adminUserSettingsPage"
        params :
          id : @user._id
  props :
    user :
      type : Object
      required : true
  components : { UserPersonalSettings, InfoAvatar}
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
