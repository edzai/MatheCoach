{ Mongo } = require "meteor/mongo"
{ Meteor } = require "meteor/meteor"

userProfileSchema = new SimpleSchema
  isMentor :
    type : Boolean
    optional : true
  mentorId :
    type : String
    optional : true
  firstName :
    type : String
    optional : true
  lastName :
    type : String
    optional : true
exports.userProfileSchema = userProfileSchema

userSchema = new SimpleSchema
  username :
    type : String
    optional : true
  emails :
    type : Array
    optional : true
  "emails.$" :
    type : Object
  "emails.$.address" :
    type : String
    regEx : SimpleSchema.RegEx.Email
  "emails.$.verified" :
    type : Boolean
  createdAt :
    type : Date
  profile :
    type : userProfileSchema
    optional : true
  services :
    type : Object
    optional : true
    blackbox : true
  roles :
    type : [String]
    optional : true
  heartbeat :
    type : Date
    optional : true
Meteor.users.attachSchema userSchema

exports.updateUserProfile = new ValidatedMethod
  name : "updateUserProfile"
  validate :
    userProfileSchema.validator()
  run : (profile) ->
    unless @userId
      throw new Meteor.Error "not logged-in"
    Meteor.users.update @userId,
      $set :
        profile : profile
