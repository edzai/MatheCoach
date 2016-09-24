{ Meteor } = require "meteor/meteor"
#require "/imports/api/methods.coffee"
require "/imports/api/collections.coffee"
require "/imports/api/users.coffee"
require "/imports/api/submissions.coffee"

if Meteor.isClient
  require "/imports/ui/router/router.coffee"

  { Accounts } = require "meteor/accounts-base"
  Accounts.ui.config
    passwordSignupFields : "USERNAME_ONLY"
