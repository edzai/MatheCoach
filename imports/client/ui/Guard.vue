<template lang="jade">
.spin-container(v-if="loading")
  Spin(size="large" fix)
div(v-else)
  slot(v-if="allowed")
  template(v-else)
    register-invitation(v-if="role === ''")
    .content-box(v-else)
      h1.heading {{$t('accessDenied')}}
      p.text {{reason}}

</template>

<script lang="coffee">
import RegisterInvitation from "./RegisterInvitation.vue"
return
  data : -> {}
  meteor :
    $subscribe :
      userOwnData : []
    roles : -> Meteor.user()?.roles or []
    loggedIn : -> Meteor.user()?
  computed :
    loading : -> not @$subReady.userOwnData
    allowed : ->
      roleFits = if @role is ""
        @loggedIn
      else
        @role in @roles
      roleFits and @andAlso
    reason : ->
      switch @role
        when "admin" then @$t "adminOnly"
        when "mentor" then @$t "mentorOnly"
        else @$t "unknownOnly"
  props :
    role :
      type : String
      required : true
    andAlso :
      type : Boolean
      default : true
  components : { RegisterInvitation }
</script>

<style scoped lang="sass">
.loading
  width : 100%
</style>
