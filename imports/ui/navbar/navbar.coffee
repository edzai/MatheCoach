{ Meteor } = require "meteor/meteor"
require "./navbar.jade"

Template.navbar.viewmodel
  isMentor : -> Meteor.user()?.profile?.isMentor
  hasMentor : -> Meteor.user()?.profile?.mentorId isnt "noMentor"
  chatUrl : -> "/chat/#{Meteor.user()?.profile?.mentorId}"
