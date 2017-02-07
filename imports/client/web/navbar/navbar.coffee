{ Meteor } = require "meteor/meteor"
{ ChatMessages } = require "/imports/api/chatMessages.coffee"
require "../navbarUserField/navbarUserField.coffee"
require "./navbar.jade"

Template.navbar.viewmodel
  share : "unsyncedCount"
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
  showUnsyncedCount : ->
    alert "#{@unsyncedCount()} Ergebnisse sind noch nicht \
      mit dem Server synchronisiert."
