import { Meteor } from "meteor/meteor"
import { Accounts } from "meteor/accounts-base"

export default authModule =
  state :
    user : null
  mutations :
    updateUser : (state, value) ->
      state.user = value
  actions :
    createUser : ( {commit, state }, options ) ->
      new Promise (resolve, reject) ->
        Accounts.createUser options, (error) ->
          if error?
            console.log error.reason
            reject error.reason
          else
            console.log "#{options.username} signed-up"
            resolve()
    loginUser : ( {commit, state }, options ) ->
      new Promise (resolve, reject) ->
        Meteor.loginWithPassword options.username, options.password, (error) ->
          if error?
            console.log error.reason
            reject error.reason
          else
            "#{options.username} signed-in"
            resolve()
    logoutUser : ->
      new Promise (resolve, reject) ->
        Meteor.logout ->
          console.log "user signed-out"
          resolve()
