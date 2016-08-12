require "./layout.jade"
require "/imports/ui/navbar/navbar.jade"
require "/imports/ui/moduleList/moduleList.coffee"
require "/imports/ui/problem/problem.coffee"
require "/imports/ui/info/info.coffee"


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

# FlowRouter.route "/outputtest",
#   name : "outputtest"
#   action : ->
#     BlazeLayout.render "layout",
#       main : "outputtest"


FlowRouter.route "/info",
  name : "info"
  action : ->
    BlazeLayout.render "layout",
      main : "info"

# FlowRouter.route "/play/:id",
#   name : "play"
#   action : ->
#     BlazeLayout.render "layout",
#       main : "play"
