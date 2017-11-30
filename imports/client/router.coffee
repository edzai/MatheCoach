import { RouterFactory, nativeScrollBehavior } from "meteor/akryum:vue-router2"

import NotFoundPage from "/imports/client/ui/NotFoundPage.vue"
import AdminUserListPage from "/imports/client/ui/AdminUserListPage.vue"
import AdminSchoolClassListPage from "/imports/client/ui/AdminSchoolClassListPage.vue"
import AdminUserSettingsPage from "/imports/client/ui/AdminUserSettingsPage.vue"
import HelpPage from "/imports/client/ui/HelpPage.vue"
import HomePage from "/imports/client/ui/HomePage.vue"
import LoginPage from "/imports/client/ui/LoginPage.vue"
import TableOfContentsPage from "/imports/client/ui/TableOfContentsPage.vue"
import UserSettingsPage from "/imports/client/ui/UserSettingsPage.vue"
import StudentResultsPage from "/imports/client/ui/StudentResultsPage.vue"
import TeacherSchoolClassList from "/imports/client/ui/TeacherSchoolClassList.vue"
import SchoolClassPage from "/imports/client/ui/SchoolClassPage.vue"
import ProblemPage from "/imports/client/ui/ProblemPage.vue"

routerFactory = new RouterFactory
  mode : "history"
  scrollBehavior : nativeScrollBehavior

RouterFactory.configure (router) ->
  router.addRoutes [
    path : "/admin-user-edit/:id"
    name : "adminUserSettingsPage"
    component : AdminUserSettingsPage
  ,
    path :"/admin-user-liste"
    name : "adminUserListPage"
    component : AdminUserListPage
  ,
    path :"/admin-klassen-liste"
    name : "adminSchoolClassListPage"
    component : AdminSchoolClassListPage
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
    path : "/meine-ergebnisse"
    name : "studentOwnResultsPage"
    component : StudentResultsPage
  ,
    path : "/ergebnisse/:id"
    name : "studentResultsPage"
    component : StudentResultsPage
  ,
    path : "/meine-klassen"
    name : "teacherSchoolClassList"
    component : TeacherSchoolClassList
  ,
    path : "/klasse/:id"
    name : "schoolClassPage"
    component : SchoolClassPage
  ,
    path : "/"
    name : "homePage"
    component : HomePage
  ,
    path : "*"
    component : NotFoundPage
  ]

export default routerFactory
