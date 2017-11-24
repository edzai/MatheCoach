<template lang="jade">
.content-box.separated
  .flex
    .left
      h1.heading {{schoolClassName}}
      p.text {{teacherName}}
    .right
      Button(
        v-if="schoolClass._id"
        type="error"
        shape="circle"
        icon="trash-a"
        @click="deleteSchoolClass"
        style="margin-right : 8px"
      )
      Button(
        v-bind:type="editing ? 'ghost' : 'primary'"
        shape="circle"
        icon="edit"
        @click="editing = !editing"
      )
  .content-no-box(v-if="editing")
    hr(style="margin : 1rem 0")
    Form(
      ref="form"
      v-bind:model="formData"
      v-bind:rules="formRules"
      v-bind:label-width="100"
    )
      FormItem(v-bind:label="$t('klassenName')" prop="name")
        Input(v-model="formData.name")
      FormItem(v-bind:label="$t('lehrer')" prop="teacherId")
        Select(v-model="formData.teacherId")
          Option(
            v-for="item in teachersList"
            v-bind:value="item.value"
            v-bind:key="item.key"
          ) {{item.label}}
      FormItem
        Button(
          type="ghost"
          @click="closeEdit"
          style="margin-right : 8px"
        ) {{$t('cancel')}}
        Button(
          type="primary"
          @click="submit"
        ) {{$t('speichern')}}
</template>

<script lang="coffee">
import { saveSchoolClass, deleteSchoolClass } from "/imports/api/schoolClasses.coffee"
return
  data : ->
    formData : { @schoolClass... }
    editing : not @schoolClass._id?
    teacherList : []
    teacher : {}
  props :
    schoolClass :
      type : Object
      required : true
  methods :
    closeEdit : ->
      @editing = false
      @$emit "closeEdit"
    submit : ->
      @$refs.form.validate (isValid) =>
        if isValid
          saveSchoolClass.call @formData, (error, result) =>
            if error
              @$Message.error "#{error}"
            else
              @$Message.success "#{@$t 'schoolClassSaved'}"
              @closeEdit()
    deleteSchoolClass : ->
      if window.confirm @$t "deleteSchoolClassQuestion"
        deleteSchoolClass.call id : @schoolClass._id, (error) =>
          if error
             @$Message.error "#{error}"
          else
            @$Message.success "#{@$t 'schoolClassDeleted'}"
  computed :
    teacherName : ->
      if @schoolClass.teacherId is ""
        @$t "keinLehrer"
      else
        @teacher?.fullName()
    schoolClassName : ->
      if @schoolClass.name is ""
        @$t "neueKlasse"
      else
        @schoolClass.name
    formRules : ->
      name : [
        required : true
        message : @$t "schoolClassNameRequired"
        trigger : "change"
      ]
      teacherId : [
        required : true
        message : @$t "teacherIdRequired"
        trigger : "change"
      ]
  meteor :
    teachersList :
      params : ->
        schoolClassId : @schoolClass._id
      update : ({schoolClassId}) -> Roles.getUsersInRole("mentor").map (teacher) ->
        label : teacher.fullName()
        value : teacher._id
        key : "#{schoolClassId}-#{teacher._id}"
    teacher :
      params : ->
        teacherId : @schoolClass.teacherId
      update : ({teacherId}) ->
        Meteor.users.findOne _id : teacherId
</script>

<style scoped lang="sass">
.flex
  display: flex
  justify-content: space-between
.left
  flex-grow : 1
  flex-shrink : 1
.right
  flex-grow : 0
  flex-shrink: 0
</style>
