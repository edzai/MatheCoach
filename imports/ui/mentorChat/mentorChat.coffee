{ Meteor } = require "meteor/meteor"
{ ChatMessages, sendMessage, markAsRead } = require "/imports/api/chatMessages.coffee"

require "./mentorChat.jade"

Template.mentorChat.viewmodel
  text : ""
  isMentor : ->
    Meteor.user()?.profile?.isMentor
  chatPartnerId : -> FlowRouter.getParam "chatPartnerId"
  chatPartner : -> Meteor.users.findOne _id : @chatPartnerId()
  chatPartnerName : -> @chatPartner().fullName()
  messages : ->
    ChatMessages.find
      $or :
        [
          senderId : Meteor.userId()
          receiverId : @chatPartner()?._id
        ,
          senderId : @chatPartner()?._id
          receiverId : Meteor.userId()
        ]
    ,
      sort :
        dateSent : -1
  sendMessage : ->
    sendMessage.call
      receiverId : @chatPartner()._id
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
    if @receiverId() is Meteor.userId()
      unless @read()
        markAsRead.call id : @_id()
