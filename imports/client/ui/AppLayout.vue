<template lang="jade">
.layout
  .hero: h1 MatheCoach
  Row(type="flex")
    Col.layout-menu-left(span="5")
      Menu(active-name="1" theme="light" width="auto" @on-select="name => select(name)")
        MenuItem(name="/") Home
        MenuItem(name="test") Test
    Col.layout-content(span="19")
      router-view
  .footer
    © 2016 - Jan Pilgenröder


</template>

<script lang="coffee">
return
  data : -> {}
  methods:
    select : (name) -> @$router.push(name)
</script>

<style scoped lang="sass">
.layout
.layout-content
  background-color: #f8f8f9
  padding : 20px
.layout-menu-left
.hero
  background-color: #2d8cf0
  color: white
  text-align: left
  padding : 20px
.footer
  background-color: #2d8cf0
  color: white
  padding: 15px
  text-align: center
</style>
