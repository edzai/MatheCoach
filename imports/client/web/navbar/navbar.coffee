{ Meteor } = require "meteor/meteor"
{ ChatMessages } = require "/imports/api/chatMessages.coffee"
require "../navbarUserField/navbarUserField.coffee"
require "/imports/client/web/setLayout/setLayout.coffee"
require "animate.css"
require "./navbar.jade"

Template.navbar.viewmodel
  share : "layout"
  mixin : "rolesForUserId"
  userId : -> Meteor.userId()
  hasTeacher : ->
    Meteor.user()?.schoolClass()?.teacherId?
  chatUrl : ->
    "/chat/#{Meteor.user()?.schoolClass?().teacherId}"
  unreadMessagesCount : ->
    query =
      receiverId : @userId()
      read : false
    if @hasTeacher()
      query.senderId = Meteor.user().schoolClass().teacherId
    ChatMessages.find(query).count()
  hasUnreadMessages : -> @unreadMessagesCount() isnt 0
  shaking : -> if @hasUnreadMessages() then "animated infinite tada" else ""
  style : ->
    "font-size" : "#{@navbarSize()}em"
