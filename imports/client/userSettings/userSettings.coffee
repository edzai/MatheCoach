{ updateUserProfile, profileFromVM } = require "/imports/api/users.coffee"
{ Meteor } = require "meteor/meteor"
_ = require "lodash"
require "./userSettings.jade"

Template.userSettingsPage.viewmodel
  profile : -> Meteor.user()?.profile

Template.userSettings.viewmodel
  #properties from Meteor.users.profile
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
    #this wont work for admin
    updateUserProfile.call
      profile : profileFromVM this
  dataChanged : ->
    if profile = Meteor.user()?.profile
      @firstName() isnt profile.firstName or
      @lastName() isnt profile.lastName or
      @isMentor() isnt profile.isMentor or
      @mentorId() isnt profile.mentorId or
      @useKaTeX() isnt profile.useKaTeX or
      @gravatar() isnt profile.gravatar
  autorun : -> #handle semantic-ui dropdown
    @mentorSelect.dropdown "set selected", @mentorId()
    @mentorSelect.dropdown "set text",
      _.chain @mentors()
      .find id : @mentorId()
      .value()?.name
