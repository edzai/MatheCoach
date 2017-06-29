require "/imports/client/web/userLinkDisplay/userLinkDisplay.coffee"
require "./editUser.jade"
require "/imports/client/shares.coffee"
_ = require "lodash"

{ updateUserProfile, toggleRole, userProfileSchema, setUserSchoolClass,
  removeUserFromClass } = require "/imports/api/users.coffee"
{ SchoolClasses } = require "/imports/api/schoolClasses.coffee"
{ testQuery } = require "/imports/api/users.coffee"

Template.editUserPage.viewmodel
  mixin : "rolesForUserId"
  userId : -> FlowRouter.getParam "userId"
  user : ->
    user = Meteor.users.findOne _id : @userId()
    user.userId = @userId()
    user
  profile : ->
    profile = @user()?.profile or {}
    profile.userId = @userId()
    profile

Template.editUserSchoolClass.viewmodel
  mixin : "rolesForUserId"
  schoolClassId : ViewModel.property.string
  oldSchoolClassId : ViewModel.property.string
  schoolClasses : ->
    SchoolClasses.find {},
      sort :
        name : 1
    .fetch().map (e) ->
      id : e._id
      name : e.name
  enableSaveButton : ->
    @schoolClassId() isnt @oldSchoolClassId()
  save : ->
    event.preventDefault()
    @oldSchoolClassId @schoolClassId()
    setUserSchoolClass.call
      userId : @_id()
      schoolClassId : @schoolClassId()
  onRendered : ->
    @oldSchoolClassId @schoolClassId()
  autorun : ->
    @schoolClassSelect.dropdown "set selected", @schoolClassId()
    @schoolClassSelect.dropdown "set text",
      _.chain @schoolClasses()
        .find id : @schoolClassId()
        .value()?.name ? ""

Template.editUserAdmin.viewmodel
  mixin : ["docHandler", "rolesForUserId"]
  docHandlerSchema : userProfileSchema
  docHandlerDoc : ->
    (Meteor.users.findOne _id : @userId())?.profile
  referenceNumber : ViewModel.property.string.notBlank
    .invalidMessage "Das Feld darf nicht lehr sein."
  allFieldsValid : ->
    @referenceNumber.valid()
  enableSaveButton : ->
    @docHandlerVMChanged() and @allFieldsValid()
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
  toggleIsAdmin : ->
    unless Roles.userIsInRole Meteor.userId(), "superAdmin"
      alert "Das darf nur der Super Administrator!"
    else
      toggleRole.call
        userId : @userId()
        role : "admin"
  toggleMayNotEditOwnProfile : ->
    toggleRole.call
      userId : @userId()
      role : "mayNotEditOwnProfile"



Template.editUserProfile.viewmodel
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
  mobile : ViewModel.property.string.notBlank
    .regex /^\d+[-]\d+$/
    .invalidMessage "Vorwahl und Rufnummer mit\
      Bindestrich getrennt, z.B.: 0123-12345"
  editLinks : false
  allFieldsValid : ->
    @firstName.valid() and
    @lastName.valid() #and
  # @dateOfBirth.valid() and
  # @street.valid() and
  # @plz.valid() and
  # @city.valid() and
  # @phone.valid()
  enableSaveButton : ->
    @docHandlerVMChanged() and @allFieldsValid()
  save : ->
    event.preventDefault()
    updateUserProfile.call
      profile : @docHandlerVMDoc()
      userId : @userId()
  onRendered : ->
    picker = new Pikaday
      field : @dateField?[0]
      format : "D.M.Y"
