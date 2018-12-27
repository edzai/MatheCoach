<template lang="pug">
Menu(
  v-bind:active-name="$route.name"
  v-bind:mode="mode"
  theme="light" width="auto"
  @on-select="name => $router.push({name})"
)
  MenuItem(name="homePage")
    .level
      Icon(type="md-home" v-bind:size="iconSize")
      span.menu-text(v-if="showText") {{$t('startSeite')}}
  //- MenuItem(name="loginPage")
  //-   .level
  //-     Icon(type="log-in" v-bind:size="iconSize")
  //-     span.menu-text(v-if="showText") {{$t('login')}}
  //- MenuItem(name="userSettingsPage")
  //-   .level
  //-     Icon(type="ios-settings" v-bind:size="iconSize")
  //-     span.menu-text(v-if="showText") {{$t('einstellungen')}}
  MenuItem(name="tableOfContentsPage")
    .level
      Icon(type="md-list" v-bind:size="iconSize")
      span.menu-text(v-if="showText") {{$t('inhalt')}}
  MenuItem(name="studentOwnResultsPage")
    .level
      Icon(type="md-stats" v-bind:size="iconSize")
      span.menu-text(v-if="showText") {{$t('meineErgebnisse')}}
  MenuItem(name="helpPage")
    .level
      Icon(type="md-help" v-bind:size="iconSize")
      span.menu-text(v-if="showText") {{$t('hilfe')}}
  MenuItem(v-if="showTeacher" name="teacherSchoolClassList")
    .level
      Icon(type="md-people" v-bind:size="iconSize")
      span.menu-text(v-if="showText") {{$t('meineKlassen')}}
  MenuItem(v-if="showAdmin" name="adminSchoolClassListPage")
    .level
      Icon(type="md-people" color="#ff9900" v-bind:size="iconSize")
      span.menu-text(v-if="showText") {{$t('klassenVerwalten')}}
  MenuItem(v-if="showAdmin" name="adminUserListPage")
    .level
      Icon(type="md-person" color="#ff9900" v-bind:size="iconSize")
      span.menu-text(v-if="showText") {{$t('userVerwalten')}}
</template>

<script lang="coffee">
export default
  data : ->
    width : window.innerWidth
    iconSize : 24
  mounted : ->
    window.addEventListener "resize", =>
      @width = window.innerWidth
  computed :
    showText : -> @width > 599
    mode : -> if @width >= 400 then "vertical" else "horizontal"
    showAdmin : -> "admin" in (@$store?.state?.auth?.user?.roles ? [])
    showTeacher : -> "mentor" in (@$store?.state?.auth?.user?.roles ? [])
</script>

<style scoped lang="sass">
.level
  display: flex
  align-items: center
  height: 100%
.menu-text
  margin-left: 10px
</style>
