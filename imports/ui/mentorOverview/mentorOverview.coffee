
{ Meteor } = require "meteor/meteor"
{ Submissions } = require "/imports/api/submissions.coffee"
{ problemDefinitions } = require "/imports/modules/mathproblems2/problemDefinitions.coffee"


require "./mentorOverview.jade"

Template.mentorOverview.viewmodel
  students : ->
    Meteor.users.find
      "profile.mentorId" : Meteor.userId()
    ,
      sort :
        "profile.lastName" : 1
        "profile.firstName" : 1


Template.studentDisplay.viewmodel
  share : "reactiveTimer"
  name : -> "#{@profile().firstName} #{@profile().lastName}"
  timeAgo : ->
    @tick()
    moment(@profile().lastActive).fromNow()
  userColor : ->
    moreThanDaysAgo = (days) =>
      moment(@profile().lastActive).isBefore moment().subtract(7, "days")
    switch
      when moreThanDaysAgo 7 then "red"
      when moreThanDaysAgo 3 then "orange"
      when moreThanDaysAgo 1 then "yellow"
      else "green"


Template.submissionDisplay.viewmodel
  share : "reactiveTimer"
  timeAgo : ->
    @tick()
    moment(@date()).fromNow()
  moduleTitle : -> problemDefinitions[@moduleKey()].title
