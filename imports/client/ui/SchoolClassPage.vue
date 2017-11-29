<template lang="jade">
Guard(role="mentor")
  h1.heading {{schoolClass.name}}
  school-class-student-list(v-bind:schoolClass="schoolClass")
</template>

<script lang="coffee">
import { SchoolClasses } from "/imports/api/schoolClasses.coffee"
import SchoolClassStudentList from "./SchoolClassStudentList.vue"
return
  data : ->
    schoolClass : {}
  meteor :
    schoolClass :
      params : -> schoolClassId : @$route.params?.id
      update : ({schoolClassId}) ->
        (SchoolClasses.findOne _id : schoolClassId) or {}
  components : { SchoolClassStudentList }
</script>

<style scoped lang="sass">
.red
  color: red
</style>
