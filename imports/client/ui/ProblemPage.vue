<template lang="jade">
.page
  h1.heading Aufgabe:
  transition(name="pulse" mode="out-in")
    display-problem(v-bind:problem="problem" v-bind:key="problem.solutionTeX")
  transition(name="drop" mode="out-in" @after-enter="focusInput")
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
    inputHeight : "370px"
  mounted : ->
    @getNewProblem()
    window.addEventListener "keyup", @handleEnter
  computed :
    moduleKey : -> @$route.params.moduleKey
    resultDisplayData : ->
      result : @result
      answer : @answer
      answerTeX : teXifyAM @answer
      solutionTeX : @problem.solutionTeX
  methods :
    handleEnter : (event) ->
      if event.key is "Enter"
        if @answered then @getNewProblem() else @submit()
    getNewProblem : ->
      @answered = false
      #get a new Problem to make sure level is valid
      language = @$store.state.i18n.locale
      newProblem = new Problem @moduleKey, @level, language
      @level = newProblem.level
      storedProblem = @$store.state.unsolvedProblems?.problem?[@moduleKey]?[@level]
      if storedProblem?
        @problem = @$store.state.unsolvedProblems?.problem?[@moduleKey]?[@level]
      else
        @problem = newProblem
        problemToStore = Object.assign @problem,
          moduleKey : @moduleKey
          level : @level
        @$store.commit "unsolvedProblems/add", problemToStore
      @answer = ""
      @focusInput()
    submit : ->
      @$store.commit "unsolvedProblems/remove",
        moduleKey : @moduleKey
        level : @level
      @inputHeight = "44px"
      @checkAnswer()
      if Meteor.userId()
        obj = _.pick @problem, [
          "moduleKey", "level", "score", "description", "skipExpression", "geometryDrawData", "functionPlotData", "problemTeX"
        ]
        submissionData = Object.assign obj,
          answerCorrect : @result.pass
          date : new Date()
          answer : @answer
        insertSubmission.call submissionData
    focusInput : -> @$refs.input?.focus()
    incLevel : ->
      @level +=1
      @getNewProblem()
    decLevel : ->
      @level -= 1
      @getNewProblem()
    checkAnswer : ->
      @result = @problem.checkAnswer @answer
      @answered = true
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
