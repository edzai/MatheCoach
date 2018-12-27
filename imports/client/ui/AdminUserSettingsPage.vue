<template lang="pug">
Guard(role="admin")
  div(v-if="user")
    .level
      info-avatar(v-bind:user="user").left
      h1.heading {{user.fullName()}} ({{user.username}})
    .separated.small-bottom
      user-personal-settings(v-bind:user="user")
    .separated
      admin-user-roles(v-bind:user="user")
</template>

<script lang="coffee">
import UserPersonalSettings from "./UserPersonalSettings.vue"
import UserSchoolClassSelect from "./UserSchoolClassSelect.vue"
import AdminUserRoles from "./AdminUserRoles.vue"
import InfoAvatar from "./InfoAvatar.vue"
export default
  data : ->
    user : {}
  meteor :
    $subscribe :
      userData : -> [id : @$route.params.id]
    user :
      params : -> id : @$route.params.id
      update : ({ id }) ->
        Meteor.users.findOne _id : id
  components : { UserPersonalSettings, UserSchoolClassSelect, AdminUserRoles, InfoAvatar }
</script>

<style scoped lang="sass">
.level
  display: flex
  margin-bottom: 8px
.left
  margin-right: 10px
.small-bottom
  padding-bottom: .1px
</style>
