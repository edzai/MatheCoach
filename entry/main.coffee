{ Meteor } = require "meteor/meteor"
require "/imports/api/users.coffee"
require "/imports/api/submissions.coffee"
require "/imports/api/chatMessages.coffee"

if Meteor.isClient
  require "/imports/ui/shares.coffee"
  require "/imports/ui/router/router.coffee"

  { Accounts } = require "meteor/accounts-base"
  Accounts.ui.config
    passwordSignupFields : "USERNAME_AND_EMAIL"

if Meteor.isServer
  Accounts.emailTemplates.from = "MatheCoach <pille@mac.com>"

  Meteor.startup ->
    admin = Meteor.users.findOne username : "admin"
    if admin?
      Roles.addUsersToRoles admin._id, ["admin"]
