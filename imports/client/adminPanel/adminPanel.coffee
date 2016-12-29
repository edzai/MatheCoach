require "./adminPanel.jade"
{ SchoolClasses, saveSchoolClass, deleteSchoolClass } = require "/imports/api/schoolClasses.coffee"
{ deleteUser, deleteSubmissions,
  sendVerificationEmail, sendTestEmail } = require "/imports/api/users.coffee"

Template.adminPanel.viewmodel
  users : ->
    Meteor.users.find {},
      sort :
        "profile.lastName" : 1
        "profile.firstName" : 1
        "username" : 1
  schoolClasses : ->
    SchoolClasses.find {},
      sort :
        name : 1
  newSchoolClass : ->
    FlowRouter.go "/neue-klasse"
    # mockupData =
    #   gradeLevel : 1
    #   suffix : "b"
    #   teacherId : "3acCf4kQ5NrWKgfLA"
    # saveSchoolClass.call data : mockupData

Template.adminSchoolClassDisplay.viewmodel
  editSchoolClass : ->
    FlowRouter.go "/klasse/#{@_id()}"
  deleteSchoolClass : ->
    deleteSchoolClass.call id : @_id()
  teacherName : ->
    profile = Meteor.users.findOne(_id : @teacherId())?.profile
    "#{profile?.lastName}, #{profile?.firstName}"

Template.adminUserDisplay.viewmodel
  share : "reactiveTimer"
  deleteUser : ->
    if @username() is "admin"
      alert "admin account kann nicht gelöscht werden"
    else
      if confirm "Benutzer #{@username()} wirklich löschen?"
        deleteUser.call id : @_id()
  schoolClassName : ->
    SchoolClasses.findOne(_id : @profile()?.schoolClassId)?.name ? "keine"
  timeAgo : ->
    @tick()
    date = moment(@profile().lastActive)
    "#{date.calendar()} (#{date.fromNow()})"
  deleteSubmissions : ->
    if confirm "Alle submissions von #{@username()} wirklich löschen?"
      deleteSubmissions.call userId : @_id()
  editUser : ->
    FlowRouter.go "/benutzer-daten/#{@_id()}"
  sendVerificationEmail : ->
    sendVerificationEmail.call userId : @_id()
    sendTestEmail.call text : "tut et dat?"
