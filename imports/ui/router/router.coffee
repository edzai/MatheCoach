require "./layout.jade"
require "/imports/ui/teXDisplay/teXDisplay.coffee"
require "/imports/ui/navbar/navbar.coffee"
require "/imports/ui/moduleList/moduleList.coffee"
require "/imports/ui/problem/problem.coffee"
require "/imports/ui/calculator/calculator.coffee"
require "/imports/ui/info/info.coffee"
require "/imports/ui/userSettings/userSettings.coffee"
require "/imports/ui/mentorOverview/mentorOverview.coffee"
require "/imports/ui/studentPage/studentPage.coffee"
require "/imports/ui/help/help.coffee"
require "/imports/ui/adminPanel/adminPanel.coffee"


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
