import authModule from "./auth.coffee"

strict = false

export default store =
  modules :
    auth : authModule
    
    locale :
      strict : strict
      namespaced : true
      state :
        language : "en"
      mutations :
        setLanguage : (state, language) ->
          Vue.i18n.set language
          moment.locale language
          state.language = language
      actions :
        set : ({commit}, newValue) ->
          commit "unsolvedProblems/removeAll", null, root : true
          commit "setLanguage", newValue

    unsolvedProblems :
      strict : strict
      namespaced : true
      state :
        problem : {}
      mutations :
        add : (state, newValue) ->
          moduleKey = newValue.moduleKey
          level = newValue.level
          state.problem[moduleKey] ?= {}
          state.problem[moduleKey][level] = newValue
        remove : (state, newValue) ->
          moduleKey = newValue.moduleKey
          level = newValue.level
          delete state.problem[moduleKey][level]
        removeAll : (state, newValue) ->
          state.problem = {}
