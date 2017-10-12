if Meteor.isClient
  { Rnd } = require "./randomGenerators.coffee"
  rnd = new Rnd()

  { re } = require "./RegExs.coffee"

  nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
  require "/imports/modules/nerdamer/Solve.js"

  { expect, chai } = require "meteor/practicalmeteor:chai"

  chai.use require("chai-string")

  {problemDefinitions} = require "./problemDefinitions.coffee"

  passes = 10

  for moduleKey, module of problemDefinitions
    for problem, index in module.problems
      levelOffset = problem.levelOffset ? 0
      levels = problem.levels.map (level) -> level + levelOffset
      describe "#{moduleKey}[#{index}]", ->
        for level in levels
          describe "on effective Level #{level}", ->
            error = null
            try
              problemObject = problem.generator(level)
            catch err
              error = err
            it "does not throw an error", ->
              expect(error).to.equal null
            it "returns an object", ->
              expect(problemObject).to.be.a "object"
            it "with a string for the problem", ->
              expect(problemObject.problem).to.be.a "string"
            it "that doesn't contain NaN, null, undefined or Infinity", ->
              expect(problemObject.problem).to.have.entriesCount "NaN", 0
              expect(problemObject.problem).to.have.entriesCount "null", 0
              expect(problemObject.problem).to.have.entriesCount "undefined", 0
              expect(problemObject.problem).to.have.entriesCount "Infinity", 0
            it "with a string for the description", ->
              expect(problemObject.description).to.be.a "string"
            it "that doesn't contain NaN, null, undefined or Infinity", ->
              expect(problemObject.description).to.have.entriesCount "NaN", 0
              expect(problemObject.description).to.have.entriesCount "null", 0
              expect(problemObject.description).to.have.entriesCount "undefined", 0
              expect(problemObject.description).to.have.entriesCount "Infinity", 0
