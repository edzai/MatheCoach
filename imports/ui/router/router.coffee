require "./layout.jade"
require "/imports/ui/navbar/navbar.jade"
require "/imports/ui/moduleList/moduleList.coffee"
require "/imports/ui/problem/problem.coffee"
require "/imports/ui/calculator/calculator.coffee"
require "/imports/ui/info/info.coffee"
require "/imports/ui/userSettings/userSettings.coffee"
require "/imports/ui/help/help.coffee"


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

FlowRouter.route "/help",
  name : "help"
  action : ->
    BlazeLayout.render "layout",
      main : "help"

# FlowRouter.route "/play/:id",
#   name : "play"
#   action : ->
#     BlazeLayout.render "layout",
#       main : "play"
