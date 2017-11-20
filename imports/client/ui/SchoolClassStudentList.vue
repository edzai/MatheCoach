<template lang="jade">
.content-no-box
  school-class-student-list-item(
    v-for="student in students"
    v-bind:key="student._id"
    v-bind:student="student"
  )
</template>

<script lang="coffee">
import SchoolClassStudentListItem from "./SchoolClassStudentListItem.vue"
return
  data : ->
    students : []
  meteor :
    students :
      params : ->
        schoolClassId : @schoolClass._id
      update: ({ schoolClassId }) ->
        Meteor.users.find { schoolClassId },
          sort :
            lastActive : 1
        .fetch()
  props :
    schoolClass : Object
    required : true
  components : { SchoolClassStudentListItem }
</script>

<style scoped lang="sass">
</style>
