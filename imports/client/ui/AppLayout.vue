<template lang="jade">
.layout
  .hero
    div
      h1 MatheCoach
    Button(type="primary" size="large" icon="log-in") {{$t('login')}}
  .grow
    .layout-menu
      app-menu
    .layout-content
      router-view
  .footer © 2016 - Jan Pilgenröder
</template>

<script lang="coffee">
import AppMenu from "./AppMenu.vue"
return
  data : -> {}
  meteor :
    $subscribe :
      userData : []
  computed :
    ready : -> @$subReady.userData
  components : { AppMenu }
</script>

<style scoped lang="sass">
.layout
  display: flex
  flex-direction: column
  min-height: 100vh
.grow
  display: flex
  flex-grow : 1
  flex-direction: row
  box-sizing: border-box
  flex-wrap: no-wrap
.layout-menu
  flex-shrink: 0
  flex-grow: 0
.layout-content
  background-color: #f8f8f9
  padding : 20px
  flex-grow: 1
  flex-shrink: 1
  flex-wrap: no-wrap
.ivu-menu-item
  padding : 10px 24px
.hero
  display: flex
  flex-direction: row
  justify-content: space-between
  background-color: #2d8cf0
  color: white
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
  flex-shrink: 1
.heading
  font-weight: bold
  color: #464c5b
  font-size: 16px
  &.sub
    font-size: 14px
  &.small
    font-size: 12px
.text
  color: #657180
  font-size: 12px
  &.help
    color: #9ea7b4
  &.disabled
    color: #c3cbd6
  &.link
    color: #3399ff

</style>
