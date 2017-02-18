require "/imports/client/web/systemMessages/systemMessages.coffee"
require "/imports/api/AccountsTemplates.coffee"
require "/imports/client/teXDisplay/teXDisplay.coffee"
require "/imports/client/web/home/home.coffee"
require "/imports/client/web/navbar/navbar.coffee"
require "/imports/client/web/moduleList/moduleList.coffee"
require "/imports/client/web/problem/problem.coffee"
require "/imports/client/web/calculator/calculator.coffee"
require "/imports/client/web/info/info.coffee"
require "/imports/client/web/userSettings/userSettings.coffee"
require "/imports/client/web/mentorOverview/mentorOverview.coffee"
require "/imports/client/web/mentorChat/mentorChat.coffee"
require "/imports/client/web/studentPage/studentPage.coffee"
require "/imports/client/web/help/help.coffee"
require "/imports/client/web/adminPanel/adminPanel.coffee"
require "/imports/client/web/editUser/editUser.coffee"
require "/imports/client/web/schoolClassSettings/schoolClassSettings.coffee"
require "./layout.coffee"



FlowRouter.notFound =
  action : ->
    BlazeLayout.render "layout",
      main : "accessDenied"

FlowRouter.route "/",
  name : "home"
  action : ->
    BlazeLayout.render "web",
      main : "home"

FlowRouter.route "/info",
  name : "info"
  action : ->
    BlazeLayout.render "web",
      main : "home"

FlowRouter.route "/help",
  name : "help"
  action : ->
    BlazeLayout.render "web",
      main : "help"

FlowRouter.route "/modules",
  name : "moduleList"
  triggersEnter: [AccountsTemplates.ensureSignedIn]
  action : ->
    BlazeLayout.render "web",
      main : "moduleList"

FlowRouter.route "/modul/:key",
  name : "problem"
  triggersEnter: [AccountsTemplates.ensureSignedIn]
  action : ->
    BlazeLayout.render "web",
      main : "problem"

FlowRouter.route "/user-settings",
  name : "userSettings"
  triggersEnter: [AccountsTemplates.ensureSignedIn]
  action : ->
    BlazeLayout.render "web",
      main : "userSettingsPage"

FlowRouter.route "/chat/:chatPartnerId",
  name : "mentorChat"
  triggersEnter: [AccountsTemplates.ensureSignedIn]
  action : ->
    BlazeLayout.render "web",
      main : "mentorChat"

FlowRouter.route "/my-results",
  name : "studentOwnPage"
  triggersEnter: [AccountsTemplates.ensureSignedIn]
  action : ->
    BlazeLayout.render "web",
      main : "studentOwnPage"

FlowRouter.route "/rechner",
  name : "calculator"
  action : ->
    BlazeLayout.render "web",
      main : "calculator"

FlowRouter.route "/mentor/overview",
  name : "mentorOverview"
  triggersEnter: [AccountsTemplates.ensureSignedIn]
  action : ->
    BlazeLayout.render "web",
      main : "mentorOverview"

FlowRouter.route "/mentor/student/:studentId",
  name : "student"
  triggersEnter: [AccountsTemplates.ensureSignedIn]
  action : ->
    BlazeLayout.render "web",
      main : "studentPage"

FlowRouter.route "/benutzer-daten/:userId",
  name : "editUser"
  triggersEnter: [AccountsTemplates.ensureSignedIn]
  action : ->
    BlazeLayout.render "web",
    main : "editUserPage"

FlowRouter.route "/admin-panel",
  name : "adminPanel"
  triggersEnter: [AccountsTemplates.ensureSignedIn]
  action : ->
    BlazeLayout.render "web",
      main : "adminPanel"

FlowRouter.route "/klasse/:schoolClassId",
  name : "editSchoolClass"
  triggersEnter : [AccountsTemplates.ensureSignedIn]
  action : ->
    BlazeLayout.render "web",
      main : "schoolClassSettings"

FlowRouter.route "/neue-klasse",
  name : "newSchoolClass"
  triggersEnter : [AccountsTemplates.ensureSignedIn]
  action : ->
    BlazeLayout.render "web",
      main : "schoolClassSettings"
