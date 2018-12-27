<template lang="pug">
div
  h1.heading {{$t('adminUserRoles')}}
  .content-box
    CheckboxGroup(v-model="checkedRoles")
      Checkbox(
        v-for="role in roles"
        v-bind:label="role.role"
        v-bind:key="role.role"
      ) {{role.description}}
</template>

<script lang="coffee">
import { setRoleOnOff } from "/imports/api/users.coffee"
import _ from "lodash"
export default
  props :
    user :
      type : Object
      required : true
  data : ->
    checkedRoles : @user.roles
    savedRoles : @user.roles
  computed :
    roles : ->
      allRoles = [
        role : "admin"
        description : @$t "hatAdminRechte"
      ,
        role : "mentor"
        description : @$t "istLehrer"
      ,
        role : "mayNotEditOwnProfile"
        description : @$t "profilGesperrt"
      ]
      _.filter allRoles, (role) => @mayEdit(role.role)
  methods :
    mayEdit : (role) ->
      unless "admin" in @$store.state.auth.user.roles
        return false
      if (role is "admin")
        unless "superAdmin" in @$store.state.auth.user.roles
          return false
        if @user._id is @$store.state.auth.user._id
          return false
      return true
  watch :
    checkedRoles : ->
      for role in @roles
        setRoleOnOff.call
          userId : @user._id
          role : role.role
          isOn : role.role in @checkedRoles
</script>

<style scoped lang="sass">
</style>
