{ updateTeXSetting, userSchema } = require "/imports/api/users.coffee"
{ Meteor } = require "meteor/meteor"
_ = require "lodash"
require "/imports/client/web/editUser/editUser.coffee"
require "/imports/client/web/mustBeLoggedIn/mustBeLoggedIn.coffee"
require "./userSettings.jade"

Template.userSettingsPage.viewmodel
  mixin : "rolesForUserId"
  userId : -> Meteor.userId()
  user : -> Meteor.user()
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
  useKaTeX : -> Meteor.user()?.useKaTeX
  toggle : ->
    event.preventDefault()
    updateTeXSetting.call
      useKaTeX : not @useKaTeX()
