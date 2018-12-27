<template lang="pug">
.level(v-if="currentUser")
  .icon-button(@click="$router.push({name : 'userSettingsPage'})")
    Icon(type="md-settings" color="white" size="30" )
  .icon-button(@click="$router.push({name : 'loginPage', params : {signingIn : true}})")
    Icon(type="md-log-out" color="white" size="30")
  gravatar.gravatar(
    v-bind:email="email"
    v-bind:size="36"
    default-img="wavatar"
  )
Button(v-else type="primary" size="large" icon="md-log-in" @click="$router.push({name : 'loginPage', params : {signingIn : false}})") {{$t('login')}}
</template>

<script lang="coffee">
import Gravatar from "vue-gravatar"
export default
  data : -> {}
  computed :
    currentUser : -> @$store.state.auth.user
    email : -> @$store.state.auth.user.emails?[0].address ? ""
  components : { Gravatar }
</script>

<style scoped lang="sass">
.level
  display: flex
  align-items: center
.gravatar
  border-radius: 50%
.icon-button
  padding: 3px 6px 3px 6px
  margin-right: 5px
  border-radius: 3px
  &:hover
    background-color : #5cadff
</style>
