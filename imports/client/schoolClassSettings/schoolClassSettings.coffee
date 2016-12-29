require "./schoolClassSettings.jade"
_ = require "lodash"
{ SchoolClasses, saveSchoolClass } = require "/imports/api/schoolClasses.coffee"

Template.schoolClassSettings.viewmodel
  schoolClass : ->
    if FlowRouter.getRouteName() is "editSchoolClass"
      SchoolClasses.findOne _id : FlowRouter.getParam "schoolClassId"
    else isNew : true

Template.schoolClassEditForm.viewmodel
  mixin : ["docHandler"]
  docHandlerSchema : SchoolClasses.schema
  docHandlerDoc : -> @parent().schoolClass()
  _id : ""
  name : ViewModel.property.string.notBlank
  teacherId : ViewModel.property.string.notBlank
  teachers : ->
    Roles.getUsersInRole "mentor"
      .fetch().map (e)->
        id : e._id
        name : "#{e.profile.lastName}, #{e.profile.firstName}"
  save : ->
    event.preventDefault()
    objToSave =
      name : @name()
      teacherId : @teacherId()
    unless @_id() is ""
      objToSave._id = @_id()
    saveSchoolClass.call objToSave
    window.history.back()
  maySave : ->
    @name.valid() and
    @teacherId.valid() and @docHandlerVMChanged()
  autorun : [
    ->
      @teacherSelect.dropdown "set selected", @teacherId()
      @teacherSelect.dropdown "set text",
        _.chain @teachers()
          .find id : @teacherId()
          .value()?.name
    -> console.log "docHandlerVMChanged", @docHandlerVMChanged()
  ]
