{ Meteor } = require "meteor/meteor"
{ ChatMessages } = require "/imports/api/chatMessages.coffee"
require "../navbarUserField/navbarUserField.coffee"
require "./navbar.jade"

Template.navbar.viewmodel
  mixin : "rolesForUserId"
  userId : -> Meteor.userId()
  hasMentor : ->
    mentorId = Meteor.user()?.profile?.mentorId and
      Roles.userIsInRole mentorId, "mentor"
  chatUrl : -> "/chat/#{@userId()?.profile?.mentorId}"
  unreadMessagesCount : ->
    ChatMessages.find
      receiverId : @userId()
      read : false
    .count()
  hasUnreadMessages : -> @unreadMessagesCount() isnt 0
