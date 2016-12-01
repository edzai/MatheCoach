require "./navbarUserField.jade"

Template.navbarUserField.viewmodel
  user : -> Meteor.user()
  userName : -> @user().username
