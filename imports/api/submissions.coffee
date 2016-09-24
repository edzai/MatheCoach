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
      problem :
        type : String
      answer :
        type : String
    .validator()
  run : ( {moduleKey, level, answerCorrect, problem, answer} )->
    unless @userId
      throw new Meteor.Error "not logged-in"
    Submissions.insert
      userId : @userId
      moduleKey : moduleKey
      level : level
      answerCorrect : answerCorrect
      date : new Date()
      problem : problem
      answer : answer
