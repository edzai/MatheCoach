{ updateUserProfile } = require "/imports/api/users.coffee"
{ Meteor } = require "meteor/meteor"
_ = require "lodash"
require "./userSettings.jade"

Template.userSettingsPage.viewmodel
  profile : -> Meteor.user()?.profile

Template.userSettings.viewmodel
  firstName : ""
  lastName : ""
  isMentor : false
  mentors : ->
    Meteor.users.find
      "profile.isMentor" : true
    .fetch()
    .map (user) ->
      name : "#{user.profile.firstName} #{user.profile.lastName}"
      id : user._id
    .concat
      name : "Ich habe keinen Lehrer/Mentor."
      id : "noMentor"
  mentorId : "noMentor"
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
  autorun : -> #handle semantic-ui dropdown
    @mentorSelect.dropdown "set selected", @mentorId()
    @mentorSelect.dropdown "set text",
      _.chain @mentors()
      .find id : @mentorId()
      .value()?.name
