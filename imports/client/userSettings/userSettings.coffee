{ updateUserProfile, userProfileSchema } = require "/imports/api/users.coffee"
{ Meteor } = require "meteor/meteor"
_ = require "lodash"
require "../editUser/editUser.coffee"
require "./userSettings.jade"

Template.userSettingsPage.viewmodel
  mixin : "rolesForUserId"
  userId : -> Meteor.userId()
  profile : ->
    profile = Meteor.user()?.profile or {}
    profile.userId = @userId()
    profile

Template.userLogout.viewmodel
  logout : ->
    Meteor.logout (error) ->
      if error
        alert "Fehler. Benutzer konnte nicht ausloggen."
      else
        FlowRouter.go "/sign-in"

Template.userSettings.viewmodel
  mixin : ["docHandler", "rolesForUserId"]
  docHandlerSchema : userProfileSchema
  docHandlerDoc : ->
    (Meteor.users.findOne _id : @userId())?.profile
  save : ->
    event.preventDefault()
    updateUserProfile.call
      profile : @docHandlerVMDoc()
      userId : @userId()
