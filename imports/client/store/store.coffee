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
        add : (state, newValue ) ->
          { language, moduleKey, level } = newValue
          state.problem[language] ?= {}
          state.problem[language][moduleKey] ?= {}
          state.problem[language][moduleKey][level] = newValue
        remove : (state, { language, moduleKey, level }) ->
          delete state.problem[language][moduleKey][level]
        removeAll : (state, newValue) ->
          state.problem = {}
