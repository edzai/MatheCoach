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
  levelScore : -> "#{@score()-@level().minScore}"
  displayScore : ""
  #label:
  starColor : -> @level().color
  click : (e) ->
    e.stopPropagation()
    @modal.modal "show"
  #modal:
  moduleTitle : -> getModuleTitle @moduleKey()
  modalHeaderText : -> "Punkte für #{@moduleTitle()}"
  modalLevelText : -> "Du hast Level #{@level().number} erreicht."
  modalTitleText : -> "Dein Titel ist: #{@level().title}."
  modalScoreText : -> "Insgesamt hast Du #{@score()} Punkte erreicht, \
    davon #{@score()-@level().minScore} auf diesem Level."
  modalNextText : ->
    if @level().nextScore?
      "Bis zum nächsten Level brauchst Du \
      noch #{@level().nextScore-@score()} Punkte."
    else
      "Du hast den derzeitigen Maximallevel erreicht!"
  autorun : ->
    unless @oldLevel() is -1
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
