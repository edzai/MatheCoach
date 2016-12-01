require "/imports/client/userLinkDisplay/userLinkDisplay.coffee"
require "./editUser.jade"
require "/imports/client/shares.coffee"


{ updateUserProfile, toggleRole, userProfileSchema } = require "/imports/api/users.coffee"
{ testQuery } = require "/imports/api/users.coffee"

Template.editUserPage.viewmodel
  mixin : "rolesForUserId"
  userId : -> FlowRouter.getParam "userId"
  profile : ->
    profile = (Meteor.users.findOne _id : @userId())?.profile or {}
    profile.userId = @userId()
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
  editLinks : false
  save : ->
    event.preventDefault()
    updateUserProfile.call
      profile : @docHandlerVMDoc()
      userId : @userId()
  onRendered : ->
    picker = new Pikaday
      field : @dateField[0]
      format : "D.M.Y"
