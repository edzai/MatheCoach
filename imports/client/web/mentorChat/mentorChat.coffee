{ Meteor } = require "meteor/meteor"
{ ChatMessages, sendMessage, markAsRead } = require "/imports/api/chatMessages.coffee"

require "./mentorChat.jade"

Template.mentorChat.viewmodel
  text : ""
  isMentor : ->
    Roles.userIsInRole Meteor.userId(), "mentor"
  chatPartnerId : -> FlowRouter.getParam "chatPartnerId"
  chatPartner : -> Meteor.users.findOne _id : @chatPartnerId()
  chatPartnerName : -> @chatPartner()?.fullName()
  messages : ->
    ChatMessages.find
      $or :
        [
          senderId : Meteor.userId()
          receiverId : @chatPartnerId()
        ,
          senderId : @chatPartnerId()
          receiverId : Meteor.userId()
        ]
    ,
      sort :
        dateSent : -1
  sendMessage : ->
    sendMessage.call
      receiverId : @chatPartnerId()
      dateSent : new Date()
      text : @text()
    @text.reset()

Template.chatMessageDisplay.viewmodel
  #properties of ChatMessages
  share : "reactiveTimer"
  timeAgo : ->
    @tick()
    date = moment(@dateSent())
    "#{date.calendar()} (#{date.fromNow()})"
  onRendered : ->
    @element
    .transition "hide"
    .transition "scale"
    if @receiverId() is Meteor.userId()
      unless @read()
        markAsRead.call id : @_id()
