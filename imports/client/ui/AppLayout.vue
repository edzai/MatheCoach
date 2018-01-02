<template lang="jade">
.layout
  .hero
    div
      h1 MatheCoach
    user-button
  .main-area
    .layout-menu
      app-menu
    .layout-content
      router-view
  .footer © 2016 - Jan Pilgenröder
</template>

<script lang="coffee">
import AppMenu from "./AppMenu.vue"
import UserButton from "./UserButton.vue"
import { Accounts } from "meteor/accounts-base"
return
  created : ->
    Meteor.setInterval (=> @$store.commit "tickle/inc"), 10000
  meteor :
    $subscribe :
      userOwnData : []
      teachersData : []
      schoolClasses : []
  computed :
    ready : -> @$subReady.userOwnData
  components : { AppMenu, UserButton }
</script>

<style scoped lang="sass">
.layout
  display: flex
  flex-direction: column
  min-height: 100vh
.main-area
  display: flex
  flex-grow : 1
  flex-direction: row
  box-sizing: border-box
  flex-wrap: no-wrap
  @media screen and (max-width: 400px)
    flex-direction: column
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
$success: #19be6b
$warning : #ff9900
$error: #ed3f14
.fail, .error
  &.text
    color: $error
  &.back
    background-color: $error
  &.glow
    box-shadow: 0px 0px 10px 2px $error
  &.stroke
    stroke: $error
  &.fill
    fill : $error
.pass, .success
  &.text
    color: $success
  &.back
    background-color: $success
  &.glow
    box-shadow: 0px 0px 10px 2px $success
  &.stroke
    stroke: $success
  &.fill
    fill : $success
.warning
  &.text
    color: $warning
  &.back
    background-color: $warning
  &.glow
    box-shadow: 0px 0px 10px 2px $warning
  &.stroke
    stroke: $warning
.content-box
  padding: 20px
  background-color: white
  // border: 1pt solid silver
  box-shadow: 1px 1px 2px silver
  border-radius: 5px
  flex-shrink: 1
.center
  text-align: center
.separated
  margin-bottom: 8px
.spin-container
  width: 100%
  height: 100%
  display: inline-block
  position: relative
.heading
  font-weight: bold
  color: #464c5b
  font-size: 18px
  &.sub
    font-size: 16px
  &.small
    font-size: 14px
.text
  color: #657180
  font-size: 14px
  &.help
    color: #9ea7b4
  &.disabled
    color: #c3cbd6
  &.link
    color: #3399ff
.list-enter-active
  transition: all .7s
.list-leave-active
  transition: all .5s
  position: absolute
.list-enter, .list-leave-to
  opacity: 0
  transform: translateX(300)
.list-move
  transition: all .6s
</style>
