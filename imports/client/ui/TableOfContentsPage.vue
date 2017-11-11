<template lang="jade">
.page
  h1.heading {{$t('inhalt')}}
  module-list-item(v-bind:item="moduleList[0]")
</template>

<script lang="coffee">
import { getModulesList } from '/imports/client/mathproblems/getModulesList.coffee'
import ModuleListItem from './ModuleListItem.vue'
return
  data : ->
    moduleList : getModulesList(@$store.state.i18n.locale)
  components : { ModuleListItem }
</script>

<style scoped lang="sass">
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

.page
  color: #333
  padding: 2rem
  background-color: white
</style>
