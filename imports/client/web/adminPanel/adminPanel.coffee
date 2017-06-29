require "./adminPanel.jade"
{ SchoolClasses, saveSchoolClass, deleteSchoolClass } =
  require "/imports/api/schoolClasses.coffee"
{ deleteUser, deleteSubmissions,
  sendVerificationEmail, sendTestEmail } = require "/imports/api/users.coffee"

Template.adminPanel.viewmodel
  userSearchString : ""
  userSearchClassIds : ->
    regex = ///#{@userSearchString()}///i
    SchoolClasses.find()
    .fetch()
    .filter (schoolClass) ->
      regex.test schoolClass?.name
    .map (schoolClass) ->
      schoolClass?._id
  users : ->
    regex = ///#{@userSearchString()}///i
    Meteor.users.find {},
      sort :
        "profile.lastName" : 1
        "profile.firstName" : 1
        "username" : 1
    .fetch()
    .filter (user) =>
      (regex.test user?.profile?.firstName) or
      (regex.test user?.profile?.lastName) or
      user?.schoolClassId in @userSearchClassIds()
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
  mixin : "timeAgo"
  emails : []
  deleteUser : ->
    if @username() is "admin"
      alert "admin account kann nicht gelöscht werden"
    else
      if confirm "Benutzer #{@username()} wirklich löschen?"
        deleteUser.call id : @_id()
  schoolClassName : ->
    if @schoolClassId?
      SchoolClasses.findOne(_id : @schoolClassId())?.name ? "keine"
    else
      "keine"
  deleteSubmissions : ->
    if confirm "Alle submissions von #{@username()} wirklich löschen?"
      deleteSubmissions.call userId : @_id()
  editUser : ->
    FlowRouter.go "/benutzer-daten/#{@_id()}"
  sendVerificationEmail : ->
    sendVerificationEmail.call userId : @_id()
    sendTestEmail.call text : "tut et dat?"
  mailLink : -> "mailto:#{@emails?()[0].address}"
  mailVerified : -> @emails?()[0].verified
