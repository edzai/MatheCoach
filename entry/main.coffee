{ Meteor } = require "meteor/meteor"
{ Accounts } = require "meteor/accounts-base"
require "/imports/api/AccountsTemplates.coffee"
require "/imports/api/users.coffee"
require "/imports/api/schoolClasses.coffee"
require "/imports/api/submissions.coffee"
require "/imports/api/chatMessages.coffee"

if Meteor.isClient
  require "/imports/client/shares.coffee"
  require "/imports/client/router/router.coffee"

  Accounts.ui.config
    passwordSignupFields : "USERNAME_AND_OPTIONAL_EMAIL"

if Meteor.isServer
  require "/imports/api/migrations.coffee"
  Accounts.emailTemplates.from = "MatheCoach <pille@mac.com>"

  Accounts.onCreateUser (options, user) ->
    user.navbarSize = 1
    user.contentSize = 1
    user.keypadSize = 1
    return user

  Meteor.startup ->
    Migrations.migrateTo "1,rerun"

    Accounts.config
      sendVerificationEmail : true

    admin = Meteor.users.findOne username : "admin"
    if admin?
      Roles.addUsersToRoles admin._id, [
        "admin", "superAdmin"
      ]
