<template lang="jade">
Guard(role="admin")
  h1.heading.separated {{$t('benutzerEinstellungen')}}
  div(v-if="user")
    .separated.small-bottom
      user-personal-settings(v-bind:user="user")
    .separated
      admin-user-roles(v-bind:user="user")
    .separated
      user-school-class-settings(v-bind:user="user")
</template>

<script lang="coffee">
import UserPersonalSettings from "./UserPersonalSettings.vue"
import UserSchoolClassSettings from "./UserSchoolClassSettings.vue"
import AdminUserRoles from "./AdminUserRoles.vue"
return
  data : ->
    user : {}
  meteor :
    user :
      params : -> id : @$route.params.id
      update : ({ id })->
        Meteor.users.findOne _id : id
  components : { UserPersonalSettings, UserSchoolClassSettings, AdminUserRoles }
</script>

<style scoped lang="sass">
.small-bottom
  padding-bottom: .1px
</style>
