<template lang="jade">
div
  h1.heading.separated {{$t('benutzerEinstellungen')}}
  div(v-if="user")
    .separated.small-bottom
      user-personal-settings(v-bind:user="user")
    .separated
      user-school-class-settings(v-bind:user="user")
</template>

<script lang="coffee">
import UserPersonalSettings from "./UserPersonalSettings.vue"
import UserSchoolClassSettings from "./UserSchoolClassSettings.vue"
return
  data : ->
    user : {}
  meteor :
    user :
      params : -> id : @$route.params.id
      update : ({ id })->
        Meteor.users.findOne _id : id
  components : { UserPersonalSettings, UserSchoolClassSettings}
</script>

<style scoped lang="sass">
.small-bottom
  padding-bottom: .1px
.separated
  margin-bottom: 10px
</style>
