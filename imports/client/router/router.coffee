require "./layout.coffee"
require "/imports/client/teXDisplay/teXDisplay.coffee"
require "/imports/client/accessDenied/accessDenied.coffee"
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

T9n.setLanguage "de"

AccountsTemplates.configure
  defaultLayout : "layout"
  defaultLayoutRegions : {}
  defaultContentRegion : "main"
  showForgotPasswordLink: true
  sendVerificationEmail : true
  enforceEmailVerification : true
  # overrideLoginErrors: true
  # enablePasswordChange: true
  # confirmPassword: true
  # continuousValidation: false

pwd = AccountsTemplates.removeField "password"
AccountsTemplates.removeField "email"
AccountsTemplates.addFields [
  _id : "username"
  type : "text"
  displayName : "username"
  required : true
  minLength : 5
,
  _id : "email"
  type : "email"
  required : true
  displayName : "email"
  re: /.+@(.+){2,}\.(.+){2,}/
  errStr : "Invalid email"
,
  pwd
]

AccountsTemplates.configureRoute "signIn"
AccountsTemplates.configureRoute "signUp"
#AccountsTemplates.configureRoute "changePwd"
AccountsTemplates.configureRoute "forgotPwd"
AccountsTemplates.configureRoute "resetPwd"

FlowRouter.Auth.allow ->
  true
,
  only : ["home", "info", "help", "moduleList",
    "signIn", "signUp", "forgotPwd", "resetPwd", "notFound"]

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
      main : "info"

FlowRouter.route "/help",
  name : "help"
  action : ->
    BlazeLayout.render "layout",
      main : "help"

FlowRouter.route "/modules",
  name : "moduleList"
  action : ->
    BlazeLayout.render "layout",
      main : "moduleList"

FlowRouter.Auth.allow ->
  Meteor.userId()?
,
  only : ["problem", "userSettings", "mentorChat", "studentOwnPage"]

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

FlowRouter.Auth.allow ->
  Meteor.userId() and Roles.userIsInRole Meteor.userId(), "mentor"
,
  only : ["calculator", "mentorOverview", "student"]

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

FlowRouter.Auth.allow ->
  Meteor.userId()? and Roles.userIsInRole Meteor.userId(), "admin"
,
  only : ["editUser", "adminPanel"]

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
