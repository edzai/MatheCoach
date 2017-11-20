<template lang="jade">
.content-no-box
  h1.heading {{$t('meineKlassen')}}
  teacher-school-class-list-item(
    v-for="schoolClass in schoolClasses"
    v-bind:key="schoolClass._id"
    v-bind:schoolClass="schoolClass"
  )

</template>

<script lang="coffee">
import { SchoolClasses } from "/imports/api/schoolClasses.coffee"
import TeacherSchoolClassListItem from "./TeacherSchoolClassListItem.vue"
return
  data : ->
    activeTab : ""
    schoolClasses : []
  meteor :
    schoolClasses :
      params : -> userId : @$store?.state?.auth?.user?._id
      update : ({ userId }) ->
        SchoolClasses.find teacherId : userId,
          sort :
            name : 1
        .fetch()
  components : { TeacherSchoolClassListItem }
</script>

<style scoped lang="sass">
</style>
