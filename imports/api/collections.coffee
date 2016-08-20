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

LevelScores = new Mongo.Collection "levelScores"
LevelScores.schema = new SimpleSchema
  moduleKey :
    type : String
  level :
    type : Number
  date :
    type : Date
  userId :
    type : String
  recent :
    type : [Boolean]
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
      result :
        type : Boolean
    .validator()
  run : ( {moduleKey, level, result} )->
    unless @userId
      throw new Meteor.Error "not logged-in"
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
          $each : [result]
          $slice : -20

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
