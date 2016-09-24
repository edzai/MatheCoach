{ Meteor } = require "meteor/meteor"
require "./navbar.jade"

Template.navbar.viewmodel
  isMentor : -> Meteor.user()?.profile?.isMentor
