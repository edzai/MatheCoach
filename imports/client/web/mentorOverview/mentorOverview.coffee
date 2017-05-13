
{ Meteor } = require "meteor/meteor"
{ SchoolClasses } = require "/imports/api/schoolClasses.coffee"
{ Submissions } = require "/imports/api/submissions.coffee"
{ ChatMessages } = require "/imports/api/chatMessages.coffee"

require "animate.css"
require "/imports/client/web/mustBeMentor/mustBeMentor.coffee"
require "./mentorOverview.jade"

Template.mentorOverview.viewmodel
  schoolClasses : ->
    SchoolClasses.find
      teacherId : Meteor.userId()
    ,
      sort :
        name : 1


Template.schoolClassListDisplay.viewmodel
  students : ->
    Meteor.users.find
      "schoolClassId" : @_id()
    ,
      sort :
        "profile.lastName" : 1
        "profile.firstName" : 1

Template.studentListDisplay.viewmodel
  #has properties of Meteor.users
  share : "reactiveTimer"
  mixin : "timeAgo"
  name : -> "#{@profile().firstName} #{@profile().lastName}"
  userColor : ->
    @tick()
    moreThanDaysAgo = (days) =>
      moment(@lastActive()).isBefore moment().subtract(days, "days")
    switch
      when moreThanDaysAgo 7 then "red"
      when moreThanDaysAgo 3 then "orange"
      when moreThanDaysAgo 1 then "yellow"
      else "green"
  hasUnreadMessagesFromStudent : ->
    ChatMessages.find
      receiverId : Meteor.userId()
      senderId : @_id()
      read : false
    .count() isnt 0
  shaking : -> if @hasUnreadMessagesFromStudent() then "animated infinite tada" else ""
  gotoStudentPage : -> FlowRouter.go "/mentor/student/#{@_id()}"
  gotoStudentChat : -> FlowRouter.go "/chat/#{@_id()}"
  mailLink : -> "mailto:#{@emails()[0].address}"
  mailVerified : -> @emails()[0].verified
