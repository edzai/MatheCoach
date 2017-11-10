import { RouterFactory, nativeScrollBehavior } from "meteor/akryum:vue-router2"
import NotFound from "/imports/client/ui/NotFound.vue"
import Home from "/imports/client/ui/Home.vue"

routerFactory = new RouterFactory
  mode : "history"
  scrollBehavior : nativeScrollBehavior

RouterFactory.configure (router) ->
  router.addRoutes [
    path : "/"
    name : "home"
    component : Home
  ,
    path : "*"
    component : NotFound
  ]

export default routerFactory
