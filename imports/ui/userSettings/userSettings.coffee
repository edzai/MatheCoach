{ updateUserProfile } = require "/imports/api/users.coffee"
{ Meteor } = require "meteor/meteor"

require "./userSettings.jade"

Template.userSettingsPage.viewmodel
  profile : -> Meteor.user()?.profile

Template.userSettings.viewmodel
  firstName : ""
  lastName : ""
  isMentor : false
  mentorId : ""
  save : (event) ->
    event.preventDefault()
    updateUserProfile.call
      firstName : @firstName()
      lastName : @lastName()
      isMentor : @isMentor()
      mentorId : @mentorId()
  dataChanged : ->
    if profile = Meteor.user()?.profile
      @firstName() isnt profile.firstName or
      @lastName() isnt profile.lastName or
      @isMentor() isnt profile.isMentor or
      @mentorId() isnt profile.mentorId
