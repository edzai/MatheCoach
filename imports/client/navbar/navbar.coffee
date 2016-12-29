{ Meteor } = require "meteor/meteor"
{ ChatMessages } = require "/imports/api/chatMessages.coffee"
require "../navbarUserField/navbarUserField.coffee"
require "./navbar.jade"

Template.navbar.viewmodel
  mixin : "rolesForUserId"
  userId : -> Meteor.userId()
  hasTeacher : ->
    Meteor.user()?.schoolClass()?.teacherId?
  chatUrl : ->
    "/chat/#{Meteor.user()?.schoolClass?().teacherId}"
  unreadMessagesCount : ->
    ChatMessages.find
      receiverId : @userId()
      read : false
    .count()
  hasUnreadMessages : -> @unreadMessagesCount() isnt 0
