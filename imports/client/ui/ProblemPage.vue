<template lang="jade">
div
  h1.heading Aufgabe:
  .content-box
    display-problem(v-bind:problem="problem")
  div(v-if="answered" key="result")
    display-result(v-bind:data="resultDisplayData")
    .panel2
      Button(type="primary" @click="getNewProblem") {{$t('neueAufgabe')}}
  .content-box.margin-top(v-if="!answered" key="panel")
    Input(v-model="answer" type="text" ref="input" autofocus=true)
    .panel
      ButtonGroup(shape="circle")
        Button(@click="decLevel" type="ghost")
          Icon(type="minus")
        Button(type="ghost") {{$t('level')}} {{level}}
        Button(@click="incLevel" type="ghost")
          Icon(type="plus")
      Button(type="primary" @click="submit") {{$t('problemSubmit')}}
</template>

<script lang="coffee">
import { Problem } from "/imports/client/mathproblems/mathproblems.coffee"
import { insertSubmission } from "/imports/api/submissions.coffee"
import { teXifyAM } from "/imports/client/mathproblems/renderAM.coffee"
import _ from "lodash"
import DisplayProblem from "/imports/client/ui/DisplayProblem.vue"
import DisplayResult from "./DisplayResult.vue"
return
  data : ->
    problem : {}
    level : 1
    answer : ""
    answered : false
    result :
      pass : true
      passTextsRequired : []
      passTextsOptional : []
      failTextsRequired : []
      failTextsOptional : []
    oldLanguage : @$store.state.i18n.locale
  created : ->
    @getNewProblem()
    window.addEventListener "keyup", @handleEnter
  mounted : ->
    if not @$store.state.auth.user? and @$store.state.notify.logInToSave
      @$store.commit "notify/logInToSave"
      @$Notice.warning
        title : @$t "notLoggedIn"
        desc : @$t "notLoggedInDescription"
        duration : 0

  beforeDestroy : ->
    window.removeEventListener "keyup", @handleEnter
  computed :
    moduleKey : -> @$route.params.moduleKey
    resultDisplayData : ->
      result : @result
      answer : @answer
      answerTeX : teXifyAM @answer
      solutionTeX : @problem.solutionTeX
    language : -> @$store.state.i18n.locale
  methods :
    handleEnter : (event) ->
      if event.key is "Enter"
        console.log "handleEnter"
        if @answered then @getNewProblem() else @submit()
    getNewProblem : ->
      @answered = false
      #get a new Problem to make sure level is valid
      language = @$store.state.i18n.locale
      newProblem = new Problem @moduleKey, @level, language
      @level = newProblem.level
      storedProblem = @$store.state.unsolvedProblems?.problem?[language]?[@moduleKey]?[@level]
      if storedProblem?
        @problem = storedProblem
      else
        @problem = newProblem
        @$store.commit "unsolvedProblems/add", @problem
      @answer = ""
      @focusInput()
    submit : ->
      language = @$store.state.i18n.locale
      @$store.commit "unsolvedProblems/remove",
        language : language
        moduleKey : @moduleKey
        level : @level
      @result = @problem.checkAnswer @answer
      @answered = true
      if Meteor.userId()
        obj = _.pick @problem, [
          "moduleKey", "title", "level", "score", "description", "skipExpression", "geometryDrawData", "functionPlotData", "problemTeX"
        ]
        submissionData = Object.assign obj,
          answerCorrect : @result.pass
          date : new Date()
          answer : @answer
        insertSubmission.call submissionData
    focusInput : -> Vue.nextTick => @$refs.input?.focus()
    incLevel : ->
      @level +=1
      @getNewProblem()
    decLevel : ->
      @level -= 1
      @getNewProblem()
  watch :
    language : -> @getNewProblem()

  components : { DisplayProblem, DisplayResult }
</script>

<style scoped lang="sass">
.margin-top
  margin-top: 20px
.panel
  margin-top: 10px
  display: flex
  justify-content: space-between
  align-items: center
.panel2
  margin-top: 10px
  display: flex
  justify-content: flex-end
</style>
