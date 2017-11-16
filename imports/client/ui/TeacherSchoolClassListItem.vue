<template lang="jade">
.content-box.separated(@click="goToClassPage")
  h1.heading {{schoolClass.name}}
</template>

<script lang="coffee">
return
  methods :
    goToClassPage : ->
      @$router.push
        name : "schoolClassPage"
        params :
          id : @schoolClass._id
  props :
    schoolClass :
      type : Object
      required : true
</script>

<style scoped lang="sass">
.separated
  margin-bottom: 5px
</style>
