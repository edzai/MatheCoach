<template lang="jade">
div
  h1.heading {{$t('userSchoolClassSettings')}}
  .content-box(v-if="!user.isTeacher()")
    Select(
      v-model="selectedSchoolClass"
      v-bind:placeholder="$t('wähleKlasseAus')"
    )
      Option(v-for="item in schoolClassList"
        v-bind:value="item.value"
        v-bind:key="item.value"
      ) {{item.label}}
  .content-box(v-else)
    p.text {{$t('lehrerHabenKeineKlasse')}}
</template>

<script lang="coffee">
import { SchoolClasses } from "/imports/api/schoolClasses.coffee"
import { setUserSchoolClass } from "/imports/api/users.coffee"
return
  data : ->
    selectedSchoolClass : @user.schoolClassId
    schoolClassList : []
  meteor :
    schoolClassList : ->
      SchoolClasses.find {},
        sort :
          name : 1
      .fetch().map (schoolClass) ->
        value : schoolClass._id
        label : schoolClass.name
  props :
    user :
      type : Object
      required : true
  watch :
    selectedSchoolClass : ->
      if @selectedSchoolClass isnt @user.schoolClassId
        setUserSchoolClass.call
          userId : @user._id
          schoolClassId : @selectedSchoolClass

</script>

<style scoped lang="sass">
</style>
