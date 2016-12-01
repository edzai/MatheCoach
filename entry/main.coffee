{ Meteor } = require "meteor/meteor"
require "/imports/api/users.coffee"
require "/imports/api/submissions.coffee"
require "/imports/api/chatMessages.coffee"

if Meteor.isClient
  require "/imports/client/shares.coffee"
  require "/imports/client/router/router.coffee"

  { Accounts } = require "meteor/accounts-base"
  Accounts.ui.config
    passwordSignupFields : "USERNAME_AND_EMAIL"

if Meteor.isServer
  { Accounts } = require "meteor/accounts-base"
  Accounts.emailTemplates.from = "MatheCoach <pille@mac.com>"

  Meteor.startup ->
    admin = Meteor.users.findOne username : "admin"
    if admin?
      Roles.addUsersToRoles admin._id, [
        "admin"
      ]
