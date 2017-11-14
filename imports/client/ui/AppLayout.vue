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
    Col.layout-content.transitioning(span="19")
      transition(name="fade" mode="out-in")
        router-view
  .footer.transitioning © 2016 - Jan Pilgenröder
</template>

<script lang="coffee">
return
  data : -> {}
</script>

<style scoped lang="sass">
.layout
  display: flex
  flex-direction: column
  min-height: 100vh
.grow
  flex-grow : 1
  box-sizing: border-box
.layout-content
  background-color: #f8f8f9
  padding : 20px
.fade-enter-active, .fade-leave-active
  transition: all .6s
.fade-leave-to
  opacity: 0
  // transform: translateY(10px)
.fade-enter
  opacity: 0
  // transform: translateY(-10px)
.absolute
  box-sizing: border-box
  position: absolute
  margin: auto
  width: 80%
.transitioning
  transition: all 1s
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

<style lang="sass">
$pass: #19be6b
$fail: #ed3f14
.fail
  &.text
    color: $fail
  &.back
    background-color: $fail
.pass
  &.text
    color: $pass
  &.back
    background-color: $pass
.content-box
  padding: 20px
  background-color: white
.heading
  font-weight: bold
  color: #464c5b
  font-size: 16px
  .sub
    font-size: 14px
  .small
    font-size: 12px
.text
  color: #657180
  font-size: 12px
  .help
    color: #9ea7b4
  .disabled
    color: #c3cbd6
  .link
    color: #3399ff

.drop-enter-active, .drop-leave-active
  transition: all .2s ease-in
  z-index: -2000px
.drop-leave-to
  opacity: 0
  transform: translateY(-30px)
.drop-enter
  opacity: 0
  transform: translateY(-30px)
.drop-move
  transition: all .5s
.pulse-enter-active
  transition: all .2s
.pulse-leave-active
  transition: all .2s
.pulse-leave-to
  transform: scale(.98)
.pulse-enter
  transform: scale(1.02)
</style>
