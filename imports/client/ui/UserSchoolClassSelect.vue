<template lang="jade">
Select(
  v-model="selectedSchoolClassId"
  v-bind:placeholder="$t('wähleKlasseAus')"
)
  Option(v-for="item in schoolClassList"
    v-bind:value="item.value"
    v-bind:key="item.value"
  ) {{item.label}}
</template>

<script lang="coffee">
import { SchoolClasses } from "/imports/api/schoolClasses.coffee"
import { setUserSchoolClass } from "/imports/api/users.coffee"
return
  data : ->
    selectedSchoolClassId : @schoolClassId
    schoolClassList : []
  meteor :
    schoolClassList : ->
      schoolClasses = SchoolClasses.find {},
        sort :
          name : 1
      .fetch()
      .map (schoolClass) ->
        value : schoolClass._id
        label : schoolClass.name
      schoolClasses.unshift
        value : ""
        label : "keine Klasse"
      schoolClasses
  props :
    schoolClassId :
      type : String
      required : true
  watch :
    selectedSchoolClassId : ->
      @$emit "update:schoolClassId", @selectedSchoolClassId

</script>

<style scoped lang="sass">
</style>
