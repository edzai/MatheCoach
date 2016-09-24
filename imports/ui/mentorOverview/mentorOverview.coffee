
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
  name : -> "#{@profile().firstName} #{@profile().lastName}"
  submissions : ->
    Submissions.find
      userId : @_id()
    ,
      sort :
        date : -1

Template.submissionDisplay.viewmodel
  timeAgo : ->
    moment(@date()).fromNow()
  moduleTitle : -> problemDefinitions[@moduleKey()].title
