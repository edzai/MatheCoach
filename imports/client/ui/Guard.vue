<template lang="jade">
.spin-container(v-if="loading")
  Spin(size="large" fix)
div(v-else)
  slot(v-if="allowed")
  .content-box(v-else)
    h1.heading Access Denied
    p.text User-roles does not contain '{{role}}'

</template>

<script lang="coffee">
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
  props :
    role :
      type : String
      required : true
    andAlso :
      type : Boolean
      default : true
</script>

<style scoped lang="sass">
.loading
  width : 100%
</style>
