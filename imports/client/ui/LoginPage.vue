<template lang="jade">
.content-no-box
  transition(name="zoom")
    .rotating.padded1(v-if="currentUser" key="signedIn")
      p.status {{$t('angemeldetAls')}}{{currentUser.username}}
      Button(type="error" icon="log-out" @click="signOut") {{$t('abmelden')}}
    .absolute(v-if="!currentUser" key="notSighnedIn")
      Checkbox.checkbox(v-model="signingIn" key="checkbox") {{$t('habeKonto')}}
      transition(name="flip")
        Form.rotating.padded2(
          v-if="signingIn"
          key="signingIn"
          ref="userData"
          v-bind:model="userData"
          v-bind:rules="userDataRules"
        )
          FormItem(prop="username")
            Input(type="text" v-model="userData.username" v-bind:placeholder="$t('benutzerName')")
              Icon(type="person" slot="prepend")
          FormItem(prop="password")
            Input(type="password" v-model="userData.password" v-bind:placeholder="$t('passwort')")
              Icon(type="locked" slot="prepend")
          FormItem
            Button(type="primary" icon="log-in" @click="submit") {{$t('anmelden')}}
        Form.rotating.padded2(
          v-else
          key="signingUp"
          ref="userData"
          v-bind:model="userData"
          v-bind:rules="userDataRules"
        )
          FormItem(prop="username")
            Input(type="text" v-model="userData.username" v-bind:placeholder="$t('benutzerName')")
              Icon(type="person" slot="prepend")
          FormItem(prop="email")
            Input(type="email" v-model="userData.email" v-bind:placeholder="$t('email')")
              Icon(type="android-mail" slot="prepend")
          FormItem(prop="password")
            Input(type="password" v-model="userData.password" v-bind:placeholder="$t('passwort')")
              Icon(type="locked" slot="prepend")
          FormItem
            Button(type="primary" icon="person-add" @click="submit") {{$t('neuesKonto')}}
  </template>

<script lang="coffee">
return
  data : ->
    userData :
      username : ""
      email : ""
      password : ""
    signingIn : false
  methods :
    submit : ->
      @$refs.userData.validate (valid) =>
        if valid
          if @signingIn then @signIn() else @signUp()
        else
          @$Message.error "Fail!"
    signIn : ->
      @$store.dispatch "loginUser", @userData
      .then null, (reason) => @$Message.error reason
    signUp : ->
      @$store.dispatch "createUser", @userData
      .then null, (reason) => @$Message.error reason
    signOut : ->
      @$store.dispatch "logoutUser"
  computed :
    currentUser : -> @$store.state.auth.user
    userDataRules : ->
      username : [
        required : true
        message : @$t('benutzerNameInvalid')
        trigger : "none"
      ]
      email : [
        required : true
        message : @$t('emailInvalid')
        trigger : "none"
      ]
      password : [
        required : true
        message : @$t('passwortInvalid1')
        trigger : "none"
      ,
        type : "string"
        min : 6
        message : @$t('passwortInvalid2')
        trigger : "change"
      ]
</script>

<style scoped lang="sass">
.content-no-box
  padding: 20px
.checkbox
  margin-bottom : 1rem
.button
  margin-bottom: 0
.padded1
  padding: 1rem
.padded2
  padding: 1rem 1rem 0 1rem
.rotating
  width: 25rem
  background-color: white
  position: absolute
  backface-visibility: hidden
.absolute
  position: absolute
.status
  font-size: 14px
  margin-bottom: 1rem
.zoom-enter-active
  transition: all 1s ease-in
.zoom-leave-active
  transition: all 1s ease-in
.zoom-enter
  transform: translateY(200px) scale(2)
  opacity: 0
.zoom-leave-to
  transform : scale(0)
  opacity: 0
.flip-enter-active, .flip-leave-active
  transition: all 1s
.flip-enter
  transform: rotateX(180deg)
.flip-leave-to
  transform: rotateX(-180deg)
</style>
