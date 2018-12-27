<template lang="pug">
div
  h2.sub.heading(v-if="hasChildren") {{item.title}}
  .childless(v-else @click="selectModule")
    h3.small.heading {{item.title}}
    p.text(v-if="item.description") {{item.description}}
  div(v-if="hasChildren")
    module-list-item(
      v-for="(subItem, index) in item.kindred"
      v-bind:item="subItem"
      v-bind:key="subItem.moduleKey || index")
</template>

<script lang="coffee">
export default
  computed :
    hasChildren : -> @item.kindred?.length > 0
  methods :
    selectModule : ->
      if @item.moduleKey
        @$router.push
          name : "problemPage"
          params :
            moduleKey : @item.moduleKey
  props : ['item']
</script>

<style scoped lang="sass">
.heading
  margin-top: 0
  font-weight: bold
  color: #464c5b
  font-size: 16px
  &.sub
    background-color: #e9eaec
    padding : 8px 14px
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
.childless
  padding : 5px 14px
  border-radius: 3px
  &:hover
    background : #5cadff
    .heading, .text
      color : white
</style>
