<template lang="pug">
Select(
  v-model="selectedLanguage"
  v-bind:placeholder="$t('wähleSpracheAus')"
)
  Option(
    v-for="languageItem in languageList"
    v-bind:value="languageItem.value"
    v-bind:key="languageItem.value"
  ) {{languageItem.label}}
</template>

<script lang="coffee">
import { setLanguage } from "/imports/api/users.coffee"
export default
  data : ->
    languageList : [
      value : "de"
      label : "Deutsch"
    ,
      value : "en"
      label : "English"
    ]
    selectedLanguage : @language
  watch :
    selectedLanguage : ->
      if @selectedLanguage?
        @$emit "update:language", @selectedLanguage
  props :
    language :
      type : String
      required : true
</script>

<style scoped lang="sass">
</style>
