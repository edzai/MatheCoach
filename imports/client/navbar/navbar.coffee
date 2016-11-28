{ Meteor } = require "meteor/meteor"
{ ChatMessages } = require "/imports/api/chatMessages.coffee"
require "./navbar.jade"

Template.navbar.viewmodel
  isMentor : -> Meteor.user()?.profile?.userType is "mentor"
  hasMentor : -> Meteor.user()?.profile?.mentorId isnt "noMentor"
  chatUrl : -> "/chat/#{Meteor.user()?.profile?.mentorId}"
  unreadMessagesCount : ->
    ChatMessages.find
      receiverId : Meteor.userId()
      read : false
    .count()
  hasUnreadMessages : -> @unreadMessagesCount() isnt 0
