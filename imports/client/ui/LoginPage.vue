<template lang="jade">
.content-no-box
  .form-box(v-if="currentUser" key="signedIn")
    p.status {{$t('angemeldetAls')}}{{currentUser.fullName()}}
    Button.button(type="error" icon="log-out" @click="signOut") {{$t('abmelden')}}
  div(v-if="!currentUser" key="notSighnedIn")
    Checkbox.checkbox(v-model="signingIn" key="checkbox") {{$t('habeKonto')}}
    .form-box
      Form(
        v-if="signingIn"
        key="signingIn"
        ref="userData"
        v-bind:model="userData"
        v-bind:rules="userDataRules"
      )
        FormItem(prop="username")
          Input(
            v-model="userData.username"
            v-bind:placeholder="$t('benutzerName')"
          )
            Icon(type="person" slot="prepend")
        FormItem(prop="password")
          Input(type="password" v-model="userData.password" v-bind:placeholder="$t('passwort')"
        )
            Icon(type="locked" slot="prepend")
        FormItem
          Button(type="primary" icon="log-in" @click="submit") {{$t('anmelden')}}
      Form(
        v-else
        key="signingUp"
        ref="userData"
        v-bind:model="userData"
        v-bind:rules="userDataRules"
      )
        FormItem(prop="username")
          Input(
            v-model="userData.username"
            v-bind:placeholder="$t('benutzerName')"
          )
            Icon(type="person" slot="prepend")
        FormItem(prop="email")
          Input(
            type="email"
            v-model="userData.email"
            v-bind:placeholder="$t('email')"
          )
            Icon(type="android-mail" slot="prepend")
        FormItem(prop="password")
          Input(
            type="password"
            v-model="userData.password"
            v-bind:placeholder="$t('passwort')"
          )
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
    signingIn : @$route.params.signingIn
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
  margin-bottom: 20px
.form-box
  padding: 20px 20px 1px 20px
  background-color: white
.status
  font-size: 14px
  margin-bottom: 1rem
</style>
