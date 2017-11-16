import { RouterFactory, nativeScrollBehavior } from "meteor/akryum:vue-router2"

import NotFoundPage from "/imports/client/ui/NotFoundPage.vue"
import AdminPage from "/imports/client/ui/AdminPage.vue"
import HelpPage from "/imports/client/ui/HelpPage.vue"
import HomePage from "/imports/client/ui/HomePage.vue"
import LoginPage from "/imports/client/ui/LoginPage.vue"
import TableOfContentsPage from "/imports/client/ui/TableOfContentsPage.vue"
import UserSettingsPage from "/imports/client/ui/UserSettingsPage.vue"
import StudentResultsPage from "/imports/client/ui/StudentResultsPage.vue"
import ProblemPage from "/imports/client/ui/ProblemPage.vue"

routerFactory = new RouterFactory
  mode : "history"
  scrollBehavior : nativeScrollBehavior

RouterFactory.configure (router) ->
  router.addRoutes [
    path :"/admin"
    name : "adminPage"
    component : AdminPage
  ,
    path : "/help"
    name : "helpPage"
    component : HelpPage
  ,
    path : "/login"
    name : "loginPage"
    component : LoginPage
  ,
    path : "/inhalt"
    name : "tableOfContentsPage"
    component : TableOfContentsPage
  ,
    path : "/einstellungen"
    name : "userSettingsPage"
    component : UserSettingsPage
  ,
    path : "/aufgabe/:moduleKey"
    name : "problemPage"
    component : ProblemPage
  ,
    path : "/ergebnisse"
    name : "studentResultsPage"
    component : StudentResultsPage
  ,
    path : "/"
    name : "homePage"
    component : HomePage
  ,
    path : "*"
    component : NotFoundPage
  ]

export default routerFactory
