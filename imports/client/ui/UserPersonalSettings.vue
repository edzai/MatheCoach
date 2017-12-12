<template lang="jade">
.content-no-box
  h1.heading {{$t('userPersonalSettings')}}
  .content-box.form
    Form(
      ref="form"
      v-bind:model="formData"
      v-bind:rules="formRules"
      v-bind:label-width="90"
    )
      FormItem(v-bind:label="$t('firstName')" prop="firstName")
        Input(v-model="formData.firstName" v-bind:placeholder="$t('firstName')")
      FormItem(v-bind:label="$t('lastName')" prop="lastName")
        Input(v-model="formData.lastName" v-bind:placeholder="$t('lastName')")
      FormItem(v-bind:label="$t('schoolClass')" prop="schoolClassId" v-if="!user.isTeacher()")
        user-school-class-select(v-bind:schoolClassId.sync="formData.schoolClassId")
      FormItem(v-bind:label="$t('sprache')" prop="language")
        user-language-select(v-bind:language.sync="formData.language")
      FormItem
        Button(type="primary" @click="submit" v-bind:disabled="!enableSubmit") {{$t('speichern')}}
</template>

<script lang="coffee">
import UserSchoolClassSelect from "./UserSchoolClassSelect.vue"
import UserLanguageSelect from "./UserLanguageSelect.vue"
import { updateUserData } from "/imports/api/users.coffee"
return
  data : ->
    formData :
      userId : @user._id
      firstName : @user.profile?.firstName or ""
      lastName : @user.profile?.lastName or ""
      schoolClassId : @user.schoolClassId or ""
      language : @user.language or ""
  computed :
    enableSubmit : ->
      @formData.firstName isnt @user.profile?.firstName or
      @formData.lastName isnt @user.profile?.lastName or
      @formData.schoolClassId isnt @user.schoolClassId or
      @formData.language isnt @user.language
    formRules : ->
      firstName : [
        required : true
        message : @$t "firstNameRequired"
        trigger : "blur"
      ]
      lastName : [
        required : true
        message : @$t "lastNameRequired"
        trigger : "blur"
      ]
      schoolClassId : [
        required : not @user.isTeacher()
        message : @$t "schoolClassRequired"
        trigger : "change"
      ]
      language : [
        required : true
        message : @$t "languageRequired"
        trigger : "change"
      ]
  methods :
    submit : ->
      @$refs.form.validate (valid) =>
        if valid
          updateUserData.call @formData
  props :
    user :
      type : Object
      required : true
  components : { UserSchoolClassSelect, UserLanguageSelect }
</script>

<style scoped lang="sass">
.form
  padding-bottom : 1px
</style>
