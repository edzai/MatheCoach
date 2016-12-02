require "./adminPanel.jade"
{ deleteUser, deleteSubmissions, verifyEmail } = require "/imports/api/users.coffee"

Template.adminPanel.viewmodel
  users : ->
    Meteor.users.find {},
      sort :
        "profile.lastName" : 1
        "profile.firstName" : 1
        "username" : 1

Template.adminUserDisplay.viewmodel
  deleteUser : ->
    if @username() is "admin"
      alert "admin account kann nicht gelöscht werden"
    else
      if confirm "Benutzer #{@username()} wirklich löschen?"
        deleteUser.call id : @_id()
  deleteSubmissions : ->
    if confirm "Alle submissions von #{@username()} wirklich löschen?"
      deleteSubmissions.call userId : @_id()
  editUser : ->
    FlowRouter.go "/benutzer-daten/#{@_id()}"
  sendVerificationEmail : ->
    verifyEmail.call userId : @_id()
