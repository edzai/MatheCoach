require "/imports/client/userLinkDisplay/userLinkDisplay.coffee"
require "./editUser.jade"
require "/imports/client/shares.coffee"
_ = require "lodash"
{ updateUserProfile, toggleRole, userProfileSchema,
  removeUserFromClass } = require "/imports/api/users.coffee"
{ SchoolClasses } = require "/imports/api/schoolClasses.coffee"
{ testQuery } = require "/imports/api/users.coffee"

Template.editUserPage.viewmodel
  mixin : "rolesForUserId"
  userId : -> FlowRouter.getParam "userId"
  profile : ->
    profile = (Meteor.users.findOne _id : @userId())?.profile or {}
    profile.userId = @userId()
    profile.schoolClassId ?= undefined
    profile

Template.editUserAdmin.viewmodel
  mixin : ["docHandler", "rolesForUserId"]
  docHandlerSchema : userProfileSchema
  docHandlerDoc : ->
    (Meteor.users.findOne _id : @userId())?.profile
  userType : ""
  editLinks : false
  save : ->
    event.preventDefault()
    updateUserProfile.call
      profile : @docHandlerVMDoc()
      userId : @userId()
  toggleIsMentor : ->
    unless Roles.userIsInRole @userId(), "mentor"
      removeUserFromClass.call id : @userId()
    toggleRole.call
      userId : @userId()
      role : "mentor"
  toggleIsParent : ->
    toggleRole.call
      userId : @userId()
      role : "parent"
  toggleMayNotEditOwnProfile : ->
    toggleRole.call
      userId : @userId()
      role : "mayNotEditOwnProfile"

Template.editUser.viewmodel
  mixin : ["docHandler", "rolesForUserId"]
  docHandlerSchema : userProfileSchema
  docHandlerDoc : ->
    (Meteor.users.findOne _id : @userId())?.profile
  #validation:
  firstName : ViewModel.property.string.notBlank.min(2).max(40)
    .invalidMessage "Der Vorname muss zwischen 2 und 40 Zeichen lang sein."
  lastName : ViewModel.property.string.notBlank.min(2).max(60)
    .invalidMessage "Der Nachname muss zwischen 2 und 60 Zeichen lang sein."
  dateOfBirth : ViewModel.property.string.notBlank
    .regex /^\d{1,2}\.\d{1,2}\.\d{4}$/
    .invalidMessage "Das Geburtsdatum muss ein herkömmliches Datum
      sein, z.B.: 1.10.2016"
  street : ViewModel.property.string.notBlank.min(3).max(80)
    .invalidMessage "Die Zeile mit Straßenname und Hausnummer muss
      zwischen 3 und 80 Zeichen lang sein."
  plz : ViewModel.property.string.notBlank
    .regex /^\d{5}$/
    .invalidMessage "Die Plz muss eine fünfstellige Ziffer sein."
  city : ViewModel.property.string.notBlank.min(3).max(80)
    .invalidMessage "Der Name der Stadt muss zwischen 3 und 80
      Zeichen lang sein."
  phone : ViewModel.property.string.notBlank
    .regex /^\d+[-]\d+$/
    .invalidMessage "Vorwahl und Rufnummer mit\
      Bindestrich getrennt, z.B.: 0123-12345"
  schoolClasses : ->
    SchoolClasses.find {},
      sort :
        name : 1
    .fetch().map (e) ->
      id : e._id
      name : e.name
  schoolClassId : ViewModel.property.string
  editLinks : false
  allFieldsValid : ->
    @firstName.valid() and
    @lastName.valid() and
    @dateOfBirth.valid() and
    @street.valid() and
    @plz.valid() and
    @city.valid() and
    @phone.valid()
  enableSaveButton : ->
    @docHandlerVMChanged() and @allFieldsValid()
  save : ->
    event.preventDefault()
    updateUserProfile.call
      profile : @docHandlerVMDoc()
      userId : @userId()
  onRendered : ->
    picker = new Pikaday
      field : @dateField[0]
      format : "D.M.Y"
  autorun : ->
    @schoolClassSelect.dropdown "set selected", @schoolClassId()
    @schoolClassSelect.dropdown "set text",
      _.chain @schoolClasses()
        .find id : @schoolClassId()
        .value()?.name ? ""
