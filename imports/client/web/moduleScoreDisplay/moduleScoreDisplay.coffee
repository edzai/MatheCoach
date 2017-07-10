require "./moduleScoreDisplay.jade"

{ Scores } = require "/imports/api/scores.coffee"

{ getModuleTitle } =
  require "/imports/client/mathproblems/getModulesList.coffee"

{ Tally } =
  require "/imports/modules/tally.coffee"

levelDefinitions = [
  [0, "😶", "Niemand", "grey"]
  [1, "😯", "Blutiger Anfänger", "blue"]
  [20, "😐", "Anfänger", "green"]
  [50, "🙂", "Fortgeschrittener", "yellow"]
  [100, "😀", "Profi", "orange"]
  [500, "🤓", "Genie", "red"]
]

level = (score) ->
  for [minScore, emoji, title, color], i in levelDefinitions
    if score >= minScore
      result = {minScore, emoji, title, color}
      result.number = i
      result.nextScore = levelDefinitions[i+1]?[0]
  result

Template.moduleScoreDisplay.viewmodel
  share : ["sound"]
  score : ->
    if false
      @tally().score()
    else
      selector =
        userId : @userId() ? Meteor.userId()
        category : @moduleKey()
      Scores.findOne(selector)?.score ? 0
  level : -> level @score()
  oldLevel : -1
  emoji : -> @level().emoji
  inProblemTemplate : -> FlowRouter.getRouteName() is "problem"
  levelScore : -> "#{@score()-@level().minScore}"
  displayScore : ""
  #label:
  starColor : -> @level().color
  click : (e) ->
    e.stopPropagation()
    @modal.modal "show"
  #modal:
  levelTitle : -> @level().title
  moduleTitle : -> "#{getModuleTitle @moduleKey()} - Level #{@level().number}"
  modalNextLevel : ->
    if @level().nextScore?
      "Bis zum nächsten Level brauchst Du \
      noch #{@level().nextScore-@score()} Punkte."
    else
      "Du hast den derzeitigen Maximallevel erreicht!"
  modalScoreText : -> "Du hast insgesamt #{@score()} Punkte erreicht, \
    davon #{@score()-@level().minScore} auf diesem Level. #{@modalNextLevel()}"
  autorun : ->
    unless @oldLevel() is -1
      if @inProblemTemplate()
        if @oldLevel() < @level().number
          @label
            .transition
              animation : "tada"
              duration : "1500ms"
              onComplete : =>
                @sound().play "userLevelUp"
                @displayScore @levelScore()
            .transition "tada"
            .transition "tada"
            .transition "tada"
        else if @oldLevel() > @level().number
          @displayScore @level @levelScore()
          @sound().play "userLevelDown"
          @label.transition "shake"
    @displayScore @levelScore()
    @oldLevel @level().number
