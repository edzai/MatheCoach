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
  skipExpression :
    type : Boolean
    optional : true
  SVGData :
    type : Object
    optional : true
    blackbox : true
  customTemplateName :
    type : String
    optional : true
  customTemplateData :
    type : Object
    optional : true
    blackbox : true
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
      skipExpression :
        type : Boolean
        optional : true
      SVGData :
        type : Object
        optional : true
        blackbox : true
      customTemplateName :
        type : String
        optional : true
      customTemplateData :
        type : Object
        optional : true
        blackbox : true
    .validator()
  run : ( objectToInsert )->
    unless @userId
      throw new Meteor.Error "not logged-in"
    now = new Date()
    objectToInsert.userId = @userId
    Submissions.insert objectToInsert
    Meteor.users.update @userId,
      $set :
        lastActive : now
    return true
