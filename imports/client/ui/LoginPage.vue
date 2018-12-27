<template lang="pug">
.content-no-box
  .form-box(v-if="currentUser")
    p.status {{$t('angemeldetAls')}}{{currentUser.fullName()}}
    Button.button(type="error" icon="md-log-out" @click="signOut") {{$t('abmelden')}}
  template(v-else)
    Checkbox.checkbox(v-model="signingIn" key="checkbox") {{$t('habeKonto')}}
    .form-box
      login-sign-in-form(v-if="signingIn")
      login-sign-up-form(v-else)
    .center
      router-link(v-bind:to="{name : 'passwordRequestPage'}").link.center {{$t('passwordVergessen')}}
</template>

<script lang="coffee">
import LoginSignInForm from "./LoginSignInForm.vue"
import LoginSignUpForm from "./LoginSignUpForm.vue"
export default
  data : ->
    signingIn : @$route.params.signingIn is "true"
  methods :
    signOut : ->
      @$store.dispatch "logoutUser"
  computed :
    currentUser : -> @$store.state.auth.user
  components : { LoginSignInForm, LoginSignUpForm }
</script>

<style scoped lang="sass">
.center
  margin-top: 6px
  text-align: center
.content-no-box
  padding: 20px
.checkbox
  margin-bottom : 1rem
.button
  margin-bottom: 20px
.form-box
  padding: 20px 20px 1px 20px
  background-color: white
.status
  font-size: 14px
  margin-bottom: 1rem
</style>
