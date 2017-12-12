<template lang="jade">
.content-box(v-if="resetting")
  h1.heading {{$t('resetPassword')}}
  Form(
    ref="form"
    v-bind:model="formData"
    v-bind:rules="formRules"
  )
    FormItem(prop="password")
      Input(
        type="password"
        v-model="formData.password"
        b-bind:placeholder="$t('password')"
      )
        Icon(type="person" slot="prepend")
    FormItem(prop="passwordRepeat")
      Input(
        type="password"
        v-model="formData.passwordRepeat"
        b-bind:placeholder="$t('passwordRepeat')"
      )
        Icon(type="person" slot="prepend")
    FormItem
      Button(type="primary" @click="submit") {{$t('changePassword')}}
div(v-else)
  h1.heading {{$t('passwordResetTitle')}}
  p.test {{$t('passwordResetDescription')}}
</template>

<script lang="coffee">
import { Accounts } from "meteor/accounts-base"
return
  data : ->
    @resetting = true
    formData :
      password : ""
      passwordRepeat : ""
  methods :
    submit : ->
      @$refs.form.validate (valid) =>
        if valid
          Accounts.resetPassword @$route.params.token, @formData.password
          @$router.push name : "loginPage"
  computed :
    formRules : ->
      passwordRepeatValidator = (rule, value, callback) =>
        if value is ""
          callback new Error @$t "passwordRequired"
        else
          unless value is @formData.passwordRepeat
            callback new Error @$t "passwordsMustMatch"
          else callback()
      #return:
      password : [
        required : true
        message : @$t "passwordRequired"
        trigger : "blur"
      ,
        type : "string"
        min : 6
        message : @$t "passwordTooShort"
        trigger : "blur"
      ]
      passwordRepeat : [
        validator : passwordRepeatValidator
        trigger : "blur"
      ]
</script>

<style scoped lang="sass">
</style>
