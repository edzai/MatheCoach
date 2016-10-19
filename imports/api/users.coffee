{ Mongo } = require "meteor/mongo"
{ Meteor } = require "meteor/meteor"
{ Tracker } = require "meteor/tracker"
{ Submissions } = require "./submissions.coffee"

md5 = require "md5"

userProfileSchema = new SimpleSchema
  firstName :
    type : String
    optional : true
  lastName :
    type : String
    optional : true
  isMentor :
    type : Boolean
    optional : true
  mentorId :
    type : String
    optional : true
  lastActive :
    type : Date
    optional : true
  useKaTeX :
    type : Boolean
    optional : true
  gravatar :
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

Meteor.users.helpers
  fullName : ->
    "#{@profile.firstName} #{@profile.lastName}"
  avatar : ->
    hash = md5(@profile?.gravatar?.toLowerCase() ? "0")
    "https://www.gravatar.com/avatar/#{hash}"
  submissions : ->
    Submissions.find
      userId : @_id()
    ,
      sort :
        date : -1
  lastSubmission : ->
    Submissions.findOne
      userId : @_id()
    ,
      sort :
        date : -1
  submissionsPage : (page = 1) ->
    Submissions.find
      userId : @_id()
    ,
      sort :
        date : -1
      limit : 10*page

exports.updateUserProfile = new ValidatedMethod
  name : "updateUserProfile"
  validate :
    userProfileSchema.validator()
  run : (profile) ->
    unless @userId
      throw new Meteor.Error "not logged-in"
    profile.lastActive = Meteor.user().profile.lastActive
    Meteor.users.update @userId,
      $set :
        profile : profile

exports.deleteUser = new ValidatedMethod
  name : "deleteUser"
  validate :
    new SimpleSchema
      id :
        type : String
    .validator()
  run : ({id}) ->
    unless @userId
      throw new Meteor.Error "not logged-in"
    unless Roles.userIsInRole @userId, "admin"
      throw new Meteor.Error "not admin"
    submissionsRemoved = Submissions.remove userId : id
    usersRemoved = Meteor.users.remove _id : id
    if Meteor.isServer
      console.log "delete user: #{id}"
      console.log "#{submissionsRemoved} submissions removed."
      console.log "#{usersRemoved} user removed."

exports.deleteSubmissions = new ValidatedMethod
  name : "deleteSubmissions"
  validate :
    new SimpleSchema
      userId :
        type : String
    .validator()
  run : ({userId}) ->
    unless @userId
      throw new Meteor.Error "not logged-in"
    unless Roles.userIsInRole @userId, "admin"
      throw new Meteor.Error "not admin"
    submissionsRemoved = Submissions.remove userId : userId
    if Meteor.isServer
      console.log "delete all submissions for user: #{userId}"
      console.log "#{submissionsRemoved} submissions removed."

if Meteor.isServer
  Meteor.publish "mentorData", ->
    Meteor.users.find
      "profile.isMentor" : true
    ,
      fields :
        username : 1
        profile : 1

  Meteor.publishComposite "allUserData", ->
    find : ->
      if Roles.userIsInRole @userId, "admin"
        Meteor.users.find()

if Meteor.isClient
  Meteor.subscribe "mentorData"
  Tracker.autorun ->
    if Roles.userIsInRole @Meteor.userId(), "admin"
      Meteor.subscribe "allUserData"
