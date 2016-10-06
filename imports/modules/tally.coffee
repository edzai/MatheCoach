#simple client-side aggregations

{ Submissions } = require "/imports/api/submissions.coffee"
_ = require "lodash"

class Tally
  constructor : (@selector) ->
  docs : ->
    options =
      sort :
        date : -1
    Submissions.find(@selector, options).fetch()
  rightCount : ->
    _(@docs())
    .filter (doc) -> doc.answerCorrect
    .value().length
  wrongCount : ->
    _(@docs())
    .filter (doc) -> not doc.answerCorrect
    .value().length
  rightPercent : ->
    try
      Math.round( @rightCount() / ( @rightCount() + @wrongCount() ) * 100)
    catch error
      console.log error.toString()
      null
  streak : ->
    _(@docs())
    .takeWhile (doc) -> doc.answerCorrect
    .value().length
  score : ->
    _(@docs())
    .filter (doc) -> doc.answerCorrect
    .map (doc) ->
      t = moment().diff(moment(doc.date))/moment.duration(2, "days")
      _.round doc.level * 100 * 2 ** -t
    .sum()


exports.Tally = Tally
