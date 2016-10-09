require "./studentPage.jade"
require "/imports/ui/activityGraph/activityGraph.coffee"
require "/imports/ui/submissionsList/submissionsList.coffee"

Template.studentPage.viewmodel
  studentId : -> FlowRouter.getParam "studentId"
  student : -> Meteor.users.findOne _id : @studentId()

Template.studentPageDisplay.viewmodel
  name : -> "#{@profile().firstName} #{@profile().lastName}"
