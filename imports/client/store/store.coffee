import authModule from "./auth.coffee"

strict = false

export default store =
  modules :
    auth : authModule
    tickle :
      strict : strict
      namespaced : true
      state :
        tick : 0
      mutations :
        inc : (state) ->
          state.tick += 1
    notify :
      strict : strict
      namespaced : true
      state :
        logInToSave : true
      mutations :
        logInToSave : (state, newValue ) ->
          state.logInToSave = false
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
