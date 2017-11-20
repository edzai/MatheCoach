import { Meteor } from "meteor/meteor"

#require "/imports/api/AccountsTemplates.coffee"
require "/imports/api/users.coffee"
require "/imports/api/schoolClasses.coffee"
require "/imports/api/submissions.coffee"
require "/imports/api/chatMessages.coffee"
require "/imports/api/activityGraphs.coffee"
require "/imports/api/publications.coffee"

import { Vue } from "meteor/akryum:vue"
import iView from "iview"
import Vuex from "vuex"
import storeDef from "/imports/client/store/store.coffee"
import VuexI18n from "vuex-i18n"
import { translationsDe } from "/imports/client/ui/translationsDe.coffee"
import { translationsEn } from "/imports/client/ui/translationsEn.coffee"

import AppLayout from "/imports/client/ui/AppLayout.vue"
import routerFactory from "/imports/client/router.coffee"

testLanguage = "de"

Meteor.startup ->
  Vue.use iView
  store = new Vuex.Store storeDef
  Vue.use VuexI18n.plugin, store
  Vue.locale = -> {}
  Vue.i18n.add "de", translationsDe
  Vue.i18n.add "en", translationsEn
  language = testLanguage ? window.navigator.language.slice 0, 2
  Vue.i18n.set language
  moment.locale language

  vm = new Vue
    el : '#app'
    render : (h) -> h(AppLayout)
    store : store
    router : routerFactory.create()
    meteor :
      meteorUser : ->
        @$store.commit "updateUser", Meteor.user()
