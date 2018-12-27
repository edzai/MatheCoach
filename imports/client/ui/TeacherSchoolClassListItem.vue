<template lang="pug">
.content-box.separated(@click="goToClassPage")
  h1.heading {{schoolClass.name}}
</template>

<script lang="coffee">
export default
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
</style>
