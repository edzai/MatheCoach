require "./layout.jade"
require "/imports/ui/navbar/navbar.jade"
#require "/imports/ui/home/home.coffee"
require "/imports/ui/problem/problem.coffee"
#require "/imports/ui/outputtest/outputtest.coffee"
require "/imports/ui/info/info.coffee"


FlowRouter.route "/",
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
