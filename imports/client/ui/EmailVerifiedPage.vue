<template lang="pug">
.content-box(v-if="verifying")
  h1.heading {{$t('verifiziereEmail')}}
div(v-else)
  .content-box(v-if="error")
    h1.heading {{$t('emailVerifizierenFehler')}}
    p.text {{error}}
  .content-box(v-else)
    h1.heading {{$t('emailVerifiziert')}}
</template>

<script lang="coffee">
import { Accounts } from "meteor/accounts-base"
export default
  data : ->
    verifying : true
    error : ""
  created : ->
    Accounts.verifyEmail @$route.params.token, (error) =>
      @verifying = false
      @error = if error? then "#{error}" else ""
</script>

<style scoped lang="sass">
</style>
