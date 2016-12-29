require "/imports/client/systemMessages/systemMessages.coffee"
require "./layout.jade"
require "/imports/api/AccountsTemplates.coffee"
require "/imports/client/teXDisplay/teXDisplay.coffee"
require "/imports/client/home/home.coffee"
require "/imports/client/navbar/navbar.coffee"
require "/imports/client/moduleList/moduleList.coffee"
require "/imports/client/problem/problem.coffee"
require "/imports/client/calculator/calculator.coffee"
require "/imports/client/info/info.coffee"
require "/imports/client/userSettings/userSettings.coffee"
require "/imports/client/mentorOverview/mentorOverview.coffee"
require "/imports/client/mentorChat/mentorChat.coffee"
require "/imports/client/studentPage/studentPage.coffee"
require "/imports/client/help/help.coffee"
require "/imports/client/adminPanel/adminPanel.coffee"
require "/imports/client/editUser/editUser.coffee"
require "/imports/client/schoolClassSettings/schoolClassSettings.coffee"


FlowRouter.notFound =
  action : ->
    BlazeLayout.render "layout",
      main : "accessDenied"

FlowRouter.route "/",
  name : "home"
  action : ->
    BlazeLayout.render "layout",
      main : "home"

FlowRouter.route "/info",
  name : "info"
  action : ->
    BlazeLayout.render "layout",
      main : "home"

FlowRouter.route "/help",
  name : "help"
  action : ->
    BlazeLayout.render "layout",
      main : "help"

FlowRouter.route "/modules",
  name : "moduleList"
  triggersEnter: [AccountsTemplates.ensureSignedIn]
  action : ->
    BlazeLayout.render "layout",
      main : "moduleList"

FlowRouter.route "/modul/:key",
  name : "problem"
  triggersEnter: [AccountsTemplates.ensureSignedIn]
  action : ->
    BlazeLayout.render "layout",
      main : "problem"

FlowRouter.route "/user-settings",
  name : "userSettings"
  triggersEnter: [AccountsTemplates.ensureSignedIn]
  action : ->
    BlazeLayout.render "layout",
      main : "userSettingsPage"

FlowRouter.route "/chat/:chatPartnerId",
  name : "mentorChat"
  triggersEnter: [AccountsTemplates.ensureSignedIn]
  action : ->
    BlazeLayout.render "layout",
      main : "mentorChat"

FlowRouter.route "/my-results",
  name : "studentOwnPage"
  triggersEnter: [AccountsTemplates.ensureSignedIn]
  action : ->
    BlazeLayout.render "layout",
      main : "studentOwnPage"

FlowRouter.route "/rechner",
  name : "calculator"
  action : ->
    BlazeLayout.render "layout",
      main : "calculator"

FlowRouter.route "/mentor/overview",
  name : "mentorOverview"
  triggersEnter: [AccountsTemplates.ensureSignedIn]
  action : ->
    BlazeLayout.render "layout",
      main : "mentorOverview"

FlowRouter.route "/mentor/student/:studentId",
  name : "student"
  triggersEnter: [AccountsTemplates.ensureSignedIn]
  action : ->
    BlazeLayout.render "layout",
      main : "studentPage"

FlowRouter.route "/benutzer-daten/:userId",
  name : "editUser"
  triggersEnter: [AccountsTemplates.ensureSignedIn]
  action : ->
    BlazeLayout.render "layout",
    main : "editUserPage"

FlowRouter.route "/admin-panel",
  name : "adminPanel"
  triggersEnter: [AccountsTemplates.ensureSignedIn]
  action : ->
    BlazeLayout.render "layout",
      main : "adminPanel"

FlowRouter.route "/klasse/:schoolClassId",
  name : "editSchoolClass"
  triggersEnter : [AccountsTemplates.ensureSignedIn]
  action : ->
    BlazeLayout.render "layout",
      main : "schoolClassSettings"

FlowRouter.route "/neue-klasse",
  name : "newSchoolClass"
  triggersEnter : [AccountsTemplates.ensureSignedIn]
  action : ->
    BlazeLayout.render "layout",
      main : "schoolClassSettings"
