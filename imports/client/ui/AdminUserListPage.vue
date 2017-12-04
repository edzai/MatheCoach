<template lang="jade">
Guard(role="admin")
  h1.heading {{$t('adminUserListPage')}}
  .level
    Select(v-model="sortOrder")
      Option(value="name") {{$t('sortName')}}
      Option(value="activity") {{$t('sortZuletztAktiv')}}
      Option(value="schoolClass") {{$t('sortSchoolClass')}}
    Input(v-model="searchString" icon="ios-search")
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
    sortOrder : "activity"
    searchString : ""
  meteor :
    $subscribe :
      allUserData : []
    users :
      params : ->
        searchString : @searchString
        sortOrder : @sortOrder
      update : ({searchString, sortOrder}) ->
        filteredArray =
          _.chain(Meteor.users.find().fetch())
          .filter (user) ->
            stringsToCheck = [
              user.fullName()
              user.username
              user.schoolClass()?.name
              user.teacher()?.fullName()
            ]
            _.some stringsToCheck, (str) ->
              str?.toLowerCase().includes searchString.toLowerCase()
        switch sortOrder
          when "name"
            filteredArray.sortBy (user) ->
              "#{user.profile?.lastName ? ''}\
              #{user.profile?.firstName ? ''}\
              #{user.username ? ''}".toLowerCase()
            .value()
          when "activity"
            filteredArray.sortBy("lastActive").reverse()
            .value()
          when "schoolClass"
            filteredArray.sortBy (user) ->
              "#{user.schoolClass()?.name ? 'zzzzzzzzzz'}
              #{user.profile?.lastName ? ''}\
              #{user.profile?.firstName ? ''}\
              #{user.username ? ''}".toLowerCase()
            .value()
  components : { AdminUserListItem }
</script>

<style scoped lang="sass">
.level
  display: flex
  justify-content: space-between
  margin-bottom: 8px
</style>
