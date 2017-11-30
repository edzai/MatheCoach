<template lang="jade">
div
  h1.heading {{$t('userLanguageSettings')}}
  .content-box
    Select(
      v-model="selectedLanguage"
      v-bind:placeholde="$t('wähleSpracheAus')"
    )
      Option(
        v-for="language in languages"
        v-bind:value="language.value"
        v-bind:key="language.value"
      ) {{language.label}}
</template>

<script lang="coffee">
import { setLanguage } from "/imports/api/users.coffee"
return
  data : ->
    languages : [
      value : "de"
      label : "Deutsch"
    ,
      value : "en"
      label : "English"
    ]
    selectedLanguage : ""
    savedLanguage : ""
  meteor :
    savedLanguage : -> Meteor.user()?.language
  watch :
    savedLanguage : ->
      if @savedLanguage isnt @selectedLanguage
        @selectedLanguage = @savedLanguage
    selectedLanguage : ->
      if @selectedLanguage
        setLanguage.call language : @selectedLanguage

</script>

<style scoped lang="sass">
</style>
