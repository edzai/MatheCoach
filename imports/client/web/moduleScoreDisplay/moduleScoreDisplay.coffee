require "./moduleScoreDisplay.jade"

{ Scores } = require "/imports/api/scores.coffee"

{ Tally } =
  require "/imports/modules/tally.coffee"

levelDefinitions = [
  [0, ""]
  [1, "Anfänger"]
  [10, "Fortgeschrittener"]
  [20, "Profi"]
]

level = (score) ->
  for [minScore, title] in levelDefinitions
    if score >= minScore
      result = {minScore, title}
  result

Template.moduleScoreDisplay.viewmodel
  score : ->
    if false
      @tally().score()
    else
      selector =
        userId : @userId() ? Meteor.userId()
        category : @moduleKey()
      Scores.findOne(selector)?.score ? 0
  text : ->
    l = level @score()
    titleString =
      if l.title
        "#{l.title} - "
      else ""
    "#{titleString}#{@score()-l.minScore}"
