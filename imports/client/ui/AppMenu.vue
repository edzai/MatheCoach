<template lang="jade">
Menu(
  v-bind:active-name="$route.name"
  theme="light" width="auto"
  @on-select="name => $router.push({name})"
)
  MenuItem(name="homePage")
    .level
      Icon(type="home" v-bind:size="iconSize")
      span.menu-text(v-if="showText") {{$t('startSeite')}}
  MenuItem(name="loginPage")
    .level
      Icon(type="log-in" v-bind:size="iconSize")
      span.menu-text(v-if="showText") {{$t('login')}}
  MenuItem(name="userSettingsPage")
    .level
      Icon(type="ios-settings" v-bind:size="iconSize")
      span.menu-text(v-if="showText") {{$t('einstellungen')}}
  MenuItem(name="tableOfContentsPage")
    .level
      Icon(type="ios-list-outline" v-bind:size="iconSize")
      span.menu-text(v-if="showText") {{$t('inhalt')}}
  MenuItem(name="studentOwnResultsPage")
    .level
      Icon(type="stats-bars" v-bind:size="iconSize")
      span.menu-text(v-if="showText") {{$t('meineErgebnisse')}}
  MenuItem(name="teacherSchoolClassList")
    .level
      Icon(type="ios-people" v-bind:size="iconSize")
      span.menu-text(v-if="showText") {{$t('meineKlassen')}}
  MenuItem(name="helpPage")
    .level
      Icon(type="help" v-bind:size="iconSize")
      span.menu-text(v-if="showText") {{$t('hilfe')}}
</template>

<script lang="coffee">
return
  data : ->
    iconSize : 24
    showText : true
</script>

<style scoped lang="sass">
.level
  display: flex
  align-items: center
.menu-text
  margin-left: 10px
</style>
