require "./adminPanel.jade"

Template.adminPanel.viewmodel
  users : ->
    Meteor.users.find {},
      sort :
        "profile.lastName" : 1
        "profile.firstName" : 1
        "username" : 1
