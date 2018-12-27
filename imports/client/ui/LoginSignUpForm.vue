<template lang="pug">
Form(
  key="signingUp"
  ref="form"
  v-bind:model="formData"
  v-bind:rules="formRules"
)
  FormItem(prop="username")
    Input(
      v-model="formData.username"
      v-bind:placeholder="$t('benutzerName')"
    )
      Icon(type="md-person" slot="prepend")
  FormItem(prop="email")
    Input(
      type="email"
      v-model="formData.email"
      v-bind:placeholder="$t('email')"
    )
      Icon(type="md-mail" slot="prepend")
  FormItem(prop="password")
    Input(
      type="password"
      v-model="formData.password"
      v-bind:placeholder="$t('passwort')"
    )
      Icon(type="md-lock" slot="prepend")
  FormItem(prop="passwordRepeat")
    Input(
      type="password"
      v-model="formData.passwordRepeat"
      v-bind:placeholder="$t('passwortWdh')"
    )
      Icon(type="md-lock" slot="prepend")
  FormItem(prop="firstName")
    Input(
      v-model="formData.firstName"
      v-bind:placeholder="$t('firstName')"
    )
      Icon(type="md-person" slot="prepend")
  FormItem(prop="lastName")
    Input(
      v-model="formData.lastName"
      v-bind:placeholder="$t('lastName')"
    )
      Icon(type="md-person" slot="prepend")
  FormItem(prop="schoolClassId")
    user-school-class-select(v-bind:schoolClassId.sync="formData.schoolClassId")
  FormItem(prop="language")
    user-language-select(v-bind:language.sync="formData.language")
  FormItem
    Button(type="primary" icon="md-person-add" @click="submit") {{$t('neuesKonto')}}
</template>

<script lang="coffee">
import UserSchoolClassSelect from "./UserSchoolClassSelect.vue"
import UserLanguageSelect from "./UserLanguageSelect.vue"
export default
  data : ->
    formData :
      username : ""
      email : ""
      password : ""
      passwordRepeat : ""
      firstName : ""
      lastName : ""
      schoolClassId : ""
      language : ""
  methods :
    submit : ->
      @$refs.form.validate (valid) =>
        if valid
          @$store.dispatch "createUser", @formData
          .then null, (reason) => @$Message.error reason
  computed :
    formRules : ->
      passwordRepeatValidator = (rule, value, callback) =>
        if value is ""
          callback new Error @$t "passwordRequired"
        else
          unless value is @formData.passwordRepeat
            callback new Error @$t "passwordsMustMatch"
          else callback()
      #return
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
      passwordRepeat : [
        validator : passwordRepeatValidator
        trigger : "blur"
      ]
      firstName : [
        required : true
        message : @$t "firstNameRequired"
        trigger : "blur"
      ]
      lastName : [
        required : true
        message : @$t "lastNameRequired"
      ]
      schoolClassId : [
        required : false
        message : @$t "schoolClassRequired"
        trigger : "none"
      ]
      language : [
        required : true
        message : @$t "languageRequired"
        trigger : "none"
      ]
  components : { UserSchoolClassSelect, UserLanguageSelect }
</script>

<style scoped lang="sass">
</style>
