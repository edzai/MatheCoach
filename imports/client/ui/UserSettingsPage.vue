<template lang="jade">
Guard(role="")
  h1.heading.separated {{$t('benutzerEinstellungen')}}
  div(v-if="currentUser")
    .separated.small-bottom
      user-personal-settings(v-bind:user="currentUser")
</template>

<script lang="coffee">
import UserPersonalSettings from "./UserPersonalSettings.vue"
import UserSchoolClassSelect from "./UserSchoolClassSelect.vue"
import UserLanguageSelect from "./UserLanguageSelect.vue"
return
  computed :
    currentUser : -> @$store.state.auth.user
  components : { UserPersonalSettings }
</script>

<style scoped lang="sass">
.small-bottom
  padding-bottom: .1px
</style>
