<template lang="jade">
.content-box
  .flex
    .left
      h1.heading {{user.fullName()}} ({{user.username}})
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
return
  data : ->
    editing : false
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
  components : { UserPersonalSettings, UserSchoolClassSettings}
</script>

<style scoped lang="sass">
.flex
  display: flex
  justify-content: space-between
</style>
