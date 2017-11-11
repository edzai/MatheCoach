<template lang="jade">
.layout
  .hero: h1 MatheCoach
  Row.grow(type="flex")
    Col.layout-menu-left(span="5")
      Menu(
        v-bind:active-name="$route.name"
        theme="light" width="auto"
        @on-select="name => $router.push({name})"
      )
        MenuItem(name="homePage")
          Icon(type="home")
          span {{$t('startSeite')}}
        MenuItem(name="loginPage")
          Icon(type="log-in")
          span {{$t('login')}}
        MenuItem(name="userSettingsPage")
          Icon(type="ios-settings")
          span {{$t('einstellungen')}}
        MenuItem(name="tableOfContentsPage")
          Icon(type="ios-list-outline")
          span {{$t('inhalt')}}
        MenuItem(name="helpPage")
          Icon(type="help")
          span {{$t('hilfe')}}
    Col.layout-content(span="19")
      router-view
  .footer © 2016 - Jan Pilgenröder
</template>

<script lang="coffee">
return
  data : -> {}
</script>

<style scoped lang="sass">
.layout
  display: flex
  flex-direction: column
  height : 100vh
.grow
  flex-grow : 1
  box-sizing: border-box
.layout-content
  background-color: #f8f8f9
  padding : 20px
.layout-menu-left
.ivu-menu-item
  padding : 10px 24px
.hero
  background-color: #2d8cf0
  color: white
  text-align: left
  padding : 20px
  flex-grow : 0
.footer
  background-color: #2d8cf0
  color: white
  padding: 15px
  text-align: center
  flex-grow : 0
</style>
