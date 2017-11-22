<template lang="jade">
Guard(role="admin")
  h1.heading {{$t('adminUserListPage')}}
  admin-user-list-item(
    v-for="user in users"
    v-bind:user ="user"
    v-bind:key="user._id"
  )
</template>

<script lang="coffee">
import AdminUserListItem from "./AdminUserListItem.vue"
return
  data : ->
    users : []
    selector : {}
    sort :
      "profile.lastName" : 1
      "profile.firstName" : 1
      username : 1
  meteor :
    users :
      params : ->
        selector : @selector
        sort : @sort
      update : ({selector, sort}) ->
        Meteor.users.find selector, { sort }
        .fetch()
  components : { AdminUserListItem }
</script>

<style scoped lang="sass">

</style>
