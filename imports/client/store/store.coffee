import authModule from "./auth.coffee"

strict = false

export default store =
  modules :
    auth : authModule
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
