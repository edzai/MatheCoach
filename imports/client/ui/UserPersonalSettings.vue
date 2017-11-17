<template lang="jade">
.content-no-box
  h1.heading {{$t('userPersonalSettings')}}
  Form(
    ref="userData"
    v-bind:model="userData"
    v-bind:rules="userDataRules"
    v-bind:label-width="80"
  )
    FormItem(v-bind:label="$t('firstName')" prop="firstName")
      Input(type="text" v-model="userData.firstName" v-bind:placeholder="$t('firstName')")
    FormItem(v-bind:label="$t('lastName')" prop="lastName")
      Input(type="text" v-model="userData.lastName" v-bind:placeholder="$t('lastName')")
    FormItem
      Button(type="primary" @click="submit") {{$t('speichern')}}
</template>

<script lang="coffee">
import { setUserSchoolClass, updateUserProfile } from "/imports/api/users.coffee"
return
  data : ->
    userData :
      firstName : @user.profile?.firstName or ""
      lastName : @user.profile?.lastName or ""
  computed :
    userDataRules : ->
      firstName : [
        required : true
        message : @$t("firstNameInvalid")
        trigger : "none"
      ]
      lastName : [
        required : true
        message : @$t("lastNameInvalid")
        trigger : "none"
      ]
  methods :
    submit : ->
      @$refs.userData.validate (valid) =>
        if valid
          profile = Object.assign @user?.profile ? {},
            firstName : @userData.firstName
            lastName : @userData.lastName
          updateUserProfile.call
            profile : profile
            userId : @user?._id
  props :
    user :
      type : Object
      required : true
</script>

<style scoped lang="sass">
</style>
