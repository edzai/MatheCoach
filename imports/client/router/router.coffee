require "./layout.jade"
require "/imports/client/teXDisplay/teXDisplay.coffee"
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


FlowRouter.route "/",
  name : "moduleList"
  action : ->
    BlazeLayout.render "layout",
      main : "moduleList"

FlowRouter.route "/modul/:key",
  name : "problem"
  action : ->
    BlazeLayout.render "layout",
      main : "problem"

FlowRouter.route "/rechner",
  name : "calculator"
  action : ->
    BlazeLayout.render "layout",
      main : "calculator"

FlowRouter.route "/info",
  name : "info"
  action : ->
    BlazeLayout.render "layout",
      main : "info"

FlowRouter.route "/user-settings",
  name : "userSettings"
  action : ->
    BlazeLayout.render "layout",
      main : "userSettingsPage"

FlowRouter.route "/mentor/overview",
  name : "mentorOverview"
  action : ->
    BlazeLayout.render "layout",
      main : "mentorOverview"

FlowRouter.route "/chat/:chatPartnerId",
  name : "mentorChat"
  action : ->
    BlazeLayout.render "layout",
      main : "mentorChat"

FlowRouter.route "/mentor/student/:studentId",
  name : "student"
  action : ->
    BlazeLayout.render "layout",
      main : "studentPage"

FlowRouter.route "/my-results",
  name : "studentOwnPage"
  action : ->
    BlazeLayout.render "layout",
      main : "studentOwnPage"

FlowRouter.route "/help",
  name : "help"
  action : ->
    BlazeLayout.render "layout",
      main : "help"

FlowRouter.route "/benutzer-daten/:userId",
  name : "editUser"
  action : ->
    BlazeLayout.render "layout",
    main : "editUserPage"

FlowRouter.route "/admin-panel",
  name : "adminPanel"
  action : ->
    BlazeLayout.render "layout",
      main : "adminPanel"

# FlowRouter.route "/play/:id",
#   name : "play"
#   action : ->
#     BlazeLayout.render "layout",
#       main : "play"
