require "./systemMessages.jade"

Template.systemMessages.viewmodel
  profileIncomplete : ->
    Meteor.userId() and not Meteor.user()?.profile?.firstName? and
    FlowRouter.getRouteName() isnt "userSettings"
