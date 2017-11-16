<template lang="jade">
.layout
  .hero: h1 MatheCoach
  Row.grow(type="flex")
    Col.layout-menu-left
      app-menu
    Col.layout-content
      router-view
  .footer © 2016 - Jan Pilgenröder
</template>

<script lang="coffee">
import AppMenu from "./AppMenu.vue"
return
  data : -> {}
  components : { AppMenu }
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
  flex-grow: 1

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
