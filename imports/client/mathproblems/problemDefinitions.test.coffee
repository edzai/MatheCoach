if Meteor.isClient
  { Rnd } = require "./randomGenerators.coffee"
  rnd = new Rnd()

  { re } = require "./RegExs.coffee"

  nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
  require "/imports/modules/nerdamer/Solve.js"

  { fractionGenerator } =
    require "./problemGenerators/fractions.coffee"
  { linearEquationGenerator } =
    require "./problemGenerators/linearEquations.coffee"
  { expressionGenerator } =
    require "./problemGenerators/expressions.coffee"
  { powersGenerator } =
    require "./problemGenerators/powers.coffee"
  { einXeinsGenerator } =
    require "./problemGenerators/einXeins.coffee"
  { polynomialDivisionGenerator } =
    require "./problemGenerators/polynomialDivision.coffee"
  { quadraticEquationGenerator } =
    require "./problemGenerators/quadraticEquations.coffee"
  { nullStellenGenerator } =
    require "./problemGenerators/nullstellen.coffee"

  { expect, chai } = require "meteor/practicalmeteor:chai"

  chai.use require("chai-string")

  generatorLibs =
    polynomialDivisionGenerator : polynomialDivisionGenerator
    einXeinsGenerator : einXeinsGenerator
    powersGenerator : powersGenerator
    expressionGenerator : expressionGenerator
    linearEquationGenerator : linearEquationGenerator
    fractionGenerator : fractionGenerator
    quadraticEquationGenerator : quadraticEquationGenerator
    nullStellenGenerator : nullStellenGenerator


  for generatorLibKey, generatorLib of generatorLibs
    for generatorKey, generator of generatorLib
      describe "#{generatorLibKey}.#{generatorKey}", ->
        for level in [1..5]
          describe "on Level #{level}", ->
            error = null
            try
              problem = generator(level)
            catch err
              error = err
            it "does not throw an error", ->
              expect(error).to.equal null
            it "returns an object", ->
              expect(problem).to.be.a "object"
            it "with a string for the problem", ->
              expect(problem.problem).to.be.a "string"
            it "that doesn't contain NaN, null, undefined or Infinity", ->
              expect(problem.problem).to.have.entriesCount "NaN", 0
              expect(problem.problem).to.have.entriesCount "null", 0
              expect(problem.problem).to.have.entriesCount "undefined", 0
              expect(problem.problem).to.have.entriesCount "Infinity", 0
            it "with a string for the description", ->
              expect(problem.description).to.be.a "string"
            it "that doesn't contain NaN, null, undefined or Infinity", ->
              expect(problem.description).to.have.entriesCount "NaN", 0
              expect(problem.description).to.have.entriesCount "null", 0
              expect(problem.description).to.have.entriesCount "undefined", 0
              expect(problem.description).to.have.entriesCount "Infinity", 0
