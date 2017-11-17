<template lang="jade">

.content-no-box
  h1.heading {{$t('benutzerEinstellungen')}}
  .content-no-box(v-if="currentUser")
    .content-box.separated.small-bottom
      user-personal-settings(v-bind:user="currentUser")
    .content-box.separated
      user-school-class-settings(v-bind:user="currentUser")
</template>

<script lang="coffee">
import UserPersonalSettings from "./UserPersonalSettings.vue"
import UserSchoolClassSettings from "./UserSchoolClassSettings.vue"
return
  computed :
    currentUser : -> @$store.state.auth.user
  components : { UserPersonalSettings, UserSchoolClassSettings}
</script>

<style scoped lang="sass">
.small-bottom
  padding-bottom: .1px
.separated
  margin-bottom: 10px
</style>
