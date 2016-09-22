{ Mongo } = require "meteor/mongo"
{ Meteor } = require "meteor/meteor"

Students = new Mongo.Collection "students"
Students.schema = new SimpleSchema
  userId :
    type : String
  currentModule :
    type : String
Students.attachSchema Students.schema
exports.Students = Students

LevelScoreDataPointsSchema = new SimpleSchema
  answerCorrect :
    type : Boolean
  date :
    type : Date
  problem :
    type : String
  answer :
    type : String

LevelScores = new Mongo.Collection "levelScores"
LevelScores.schema = new SimpleSchema
  moduleKey :
    type : String
  level :
    type : Number
  userId :
    type : String
  recent :
    type : [LevelScoreDataPointsSchema]
LevelScores.attachSchema LevelScores.schema
exports.LevelScores = LevelScores

exports.resetLevelScores = new ValidatedMethod
  name : "resetLevelScores"
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

exports.updateLevelScores = new ValidatedMethod
  name : "updateLevelScores"
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
    dataPoint =
      answerCorrect : answerCorrect
      date : new Date()
      problem : problem
      answer : answer
    LevelScores.upsert
      userId : @userId
      moduleKey : moduleKey
      level : level
    ,
      $setOnInsert :
        moduleKey : moduleKey
        level : level
        date : new Date()
        userId : @userId
        recent : []
      $set :
        date : new Date()
      $push :
        recent :
          $each : [dataPoint]
          $slice : -100

#Wird derzeit nicht benutzt
ModuleScores = new Mongo.Collection "moduleScores"
ModuleScores.schema = new SimpleSchema
  moduleKey :
    type : String
  userId :
    type : String
  rightCount :
    type : Number
  wrongCount :
    type : Number
  streak :
    type : Number
ModuleScores.attachSchema ModuleScores.schema
exports.ModuleScores = ModuleScores

exports.updateModuleScores = new ValidatedMethod
  name : "updateModuleScores"
  validate :
    new SimpleSchema
      moduleKey :
        type : String
      answerCorrect :
        type : Boolean
    .validator()
  run : ( {moduleKey, answerCorrect} ) ->
    unless @userId
      throw new Meteor.Error "not logged-in"
    ModuleScores.upsert
      userId : @userId
      moduleKey : moduleKey
    ,
      $setOnInsert :
        userId : @userId
        moduleKey : moduleKey
        rightCount : 0
        wrongCount : 0
        streak : 0
      $inc :
        if answerCorrect
          rightCount : 1
          streak : 1
        else
          wrongCount : 1
      $set :
        unless answerCorrect
          streak : 0
