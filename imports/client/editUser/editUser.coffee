require "/imports/client/userLinkDisplay/userLinkDisplay.coffee"
require "./editUser.jade"
require "/imports/client/shares.coffee"


{ updateUserProfile, userProfileSchema } = require "/imports/api/users.coffee"
{ testQuery } = require "/imports/api/users.coffee"

Template.editUserPage.viewmodel
  userId : -> FlowRouter.getParam "userId"
  profile : -> (Meteor.users.findOne _id : @userId())?.profile
  mayEdit : true

Template.editUser.viewmodel
  mixin : "docHandler"
  docHandlerSchema : userProfileSchema
  docHandlerDoc : ->
    (Meteor.users.findOne _id : @userId())?.profile
  userId : -> FlowRouter.getParam "userId"
  userType : ""
  isMentor : -> @userType() is "mentor"
  isStudent : -> @userType() is "student"
  isParent : -> @userType() is "parent"
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
