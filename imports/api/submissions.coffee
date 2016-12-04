{ Mongo } = require "meteor/mongo"
{ Meteor } = require "meteor/meteor"

require "./users.coffee"

Submissions = new Mongo.Collection "submissions"
Submissions.schema = new SimpleSchema
  userId :
    type : String
  moduleKey :
    type : String
  level :
    type : Number
  answerCorrect :
    type : Boolean
  date :
    type : Date
  description :
    type : String
  problem :
    type : String
  answer :
    type : String
    optional : true
Submissions.attachSchema Submissions.schema
exports.Submissions = Submissions

exports.resetSubmissions = new ValidatedMethod
  name : "resetSubmissions"
  validate :
    new SimpleSchema
      moduleKey :
        type : String
    .validator()
  run : ({moduleKey}) ->
    unless @userId
      throw new Meteor.Error "not logged-in"
    LevelScores.remove
      userId : @userId
      moduleKey : moduleKey

exports.insertSubmission = new ValidatedMethod
  name : "insertSubmission"
  validate :
    new SimpleSchema
      moduleKey :
        type : String
      level :
        type : Number
      answerCorrect :
        type : Boolean
      description :
        type : String
      problem :
        type : String
      answer :
        type : String
      date :
        type : Date
    .validator()
  run : ( objectToInsert )->
    unless @userId
      throw new Meteor.Error "not logged-in"
    now = new Date()
    objectToInsert.userId = @userId
    Submissions.insert objectToInsert
    Meteor.users.update @userId,
      $set :
        "profile.lastActive" : now

if Meteor.isServer
  Meteor.publish "userSubmissions", ->
    unless @userId
      @ready()
    else
      Submissions.find userId : @userId

  Meteor.publishComposite "studentSubmissions", ->
    find : ->
      Meteor.users.find
        _id : @userId
      ,
        fields :
          username : 1
          profile : 1
          emails : 1
    children : [
      find : (mentor) ->
        Meteor.users.find
          "profile.mentorId" : mentor._id
        ,
          fields :
            username : 1
            profile : 1
            emails : 1
      children : [
        find : (student) ->
          Submissions.find userId : student._id
      ]
    ]

if Meteor.isClient
  Meteor.subscribe "userSubmissions"
  Meteor.subscribe "studentSubmissions"
