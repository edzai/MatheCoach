<template lang="jade">
.content-no-box
  h1.heading {{$t('userSchoolClassSettings')}}
  div(v-if="!user.isTeacher()")
    Select(
      v-model="selectedSchoolClass"
      v-bind:placeholder="$t('wähleKlasseAus')"
    )
      Option(v-for="item in schoolClassList"
        v-bind:value="item.value"
        v-bind:key="item.value"
      ) {{item.label}}
  div(v-else)
    p.text {{$t('lehrerHabenKeineKlasse')}}
</template>

<script lang="coffee">
import { SchoolClasses } from "/imports/api/schoolClasses.coffee"
import { setUserSchoolClass } from "/imports/api/users.coffee"
return
  data : ->
    selectedSchoolClass : @user.schoolClassId
  meteor :
    schoolClassList : ->
      SchoolClasses.find().fetch().map (schoolClass) ->
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
