<template lang="pug">
.spin-container(v-if="!$subReady.schoolClassUsers")
  Spin(size="large")
.content-no-box(v-else)
  .level
    Select(v-model="sortOrder")
      Option(value="name") {{$t('sortName')}}
      Option(value="activity") {{$t('sortZuletztAktiv')}}
  transition-group(name="list")
    school-class-student-list-item(
      v-for="student in students"
      v-bind:key="student._id"
      v-bind:student="student"
    )
</template>

<script lang="coffee">
import SchoolClassStudentListItem from "./SchoolClassStudentListItem.vue"
export default
  data : ->
    students : []
    sortOrder : "activity"
  meteor :
    $subscribe :
      schoolClassUsers : -> [schoolClassId : @schoolClass._id]
    students :
      params : ->
        schoolClassId : @schoolClass._id
        sortOrder : @sortOrder
      update: ({ schoolClassId, sortOrder }) ->
        users =
          _.chain(
            Meteor.users.find { schoolClassId },
              sort :
                lastActive : 1
            .fetch())
        switch sortOrder
          when "name"
            users.sortBy (user) ->
              "#{user.profile?.lastName ? ''}\
              #{user.profile?.firstName ? ''}\
              #{user.username ? ''}".toLowerCase()
            .value()
          when "activity"
            users.sortBy("lastActive").reverse()
            .value()
          else users.value()
  props :
    schoolClass : Object
    required : true
  components : { SchoolClassStudentListItem }
</script>

<style scoped lang="sass">
.level
  margin-bottom: 8px
</style>
