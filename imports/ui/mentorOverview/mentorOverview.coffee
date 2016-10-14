
{ Meteor } = require "meteor/meteor"
{ Submissions } = require "/imports/api/submissions.coffee"

require "./mentorOverview.jade"

Template.mentorOverview.viewmodel
  students : ->
    Meteor.users.find
      "profile.mentorId" : Meteor.userId()
    ,
      sort :
        "profile.lastName" : 1
        "profile.firstName" : 1


Template.studentListDisplay.viewmodel
  share : "reactiveTimer"
  name : -> "#{@profile().firstName} #{@profile().lastName}"
  timeAgo : ->
    @tick()
    date = moment(@profile().lastActive)
    "#{date.calendar()} (#{date.fromNow()})"
  userColor : ->
    @tick()
    moreThanDaysAgo = (days) =>
      moment(@profile().lastActive).isBefore moment().subtract(days, "days")
    switch
      when moreThanDaysAgo 7 then "red"
      when moreThanDaysAgo 3 then "orange"
      when moreThanDaysAgo 1 then "yellow"
      else "green"
  gotoStudentPage : -> FlowRouter.go "/mentor/student/#{@_id()}"
  gotoStudentChat : -> FlowRouter.go "/chat/#{@_id()}"
