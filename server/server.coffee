import { Meteor } from 'meteor/meteor'

#require "/imports/api/AccountsTemplates.coffee"
require "/imports/api/users.coffee"
require "/imports/api/schoolClasses.coffee"
require "/imports/api/submissions.coffee"
require "/imports/api/chatMessages.coffee"
require "/imports/api/activityGraphs.coffee"
require "/imports/api/publications.coffee"

Meteor.startup ->
  admin = Meteor.users.findOne username : "admin"
  if admin?
    Roles.addUsersToRoles admin._id, [
      "admin", "superAdmin"
    ]
