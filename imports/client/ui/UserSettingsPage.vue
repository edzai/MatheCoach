<template lang="jade">
div
  h1.heading.separated {{$t('benutzerEinstellungen')}}
  div(v-if="currentUser")
    .separated.small-bottom
      user-personal-settings(v-bind:user="currentUser")
    .separated
      user-school-class-settings(v-bind:user="currentUser")
    .separated
      user-language-settings
</template>

<script lang="coffee">
import UserPersonalSettings from "./UserPersonalSettings.vue"
import UserSchoolClassSettings from "./UserSchoolClassSettings.vue"
import UserLanguageSettings from "./UserLanguageSettings.vue"
return
  computed :
    currentUser : -> @$store.state.auth.user
  components : { UserPersonalSettings, UserSchoolClassSettings, UserLanguageSettings }
</script>

<style scoped lang="sass">
.small-bottom
  padding-bottom: .1px
.separated
  margin-bottom: 10px
</style>
