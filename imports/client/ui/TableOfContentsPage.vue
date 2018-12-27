<template lang="pug">
.content-box
  h1.heading {{$t('inhalt')}}
  module-list-item(v-bind:item="moduleList[0]")
</template>

<script lang="coffee">
import { getModulesList } from '/imports/client/mathproblems/getModulesList.coffee'
import ModuleListItem from './ModuleListItem.vue'
export default
  computed :
    moduleList : -> getModulesList(@$store.state.i18n.locale)
  components : { ModuleListItem }
</script>

<style scoped lang="sass">
</style>
