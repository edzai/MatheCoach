require "./moduleScoreDisplay.jade"

{ Howl } = require "howler"

{ Scores } = require "/imports/api/scores.coffee"

{ getModuleTitle } = require "/imports/client/mathproblems/getModulesList.coffee"

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
  #label:
  text : ->
    titleString =
      if @level().title
        "#{@level().title} - "
      else ""
    "#{@level().emoji} #{@score()-@level().minScore}"
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
      "Du hast den derzeititen Maximallevel erreicht!"
  sound : new Howl
    src : ["sounds.m4a", "sounds.mp3"]
    sprite :
      right : [930, 2000-930]
      wrong : [2560, 3530-2560]
      difficultylUp : [4510, 6110-4510]
      difficultyDown : [6560, 8260-6560]
      userLevelUp : [9230, 10880-9230]
      userLevelDown : [11730, 13120-11730]
  autorun : ->
    console.log "level:", @oldLevel(), @level()
    if @oldLevel() is -1
      @oldLevel @level().number
    else
      if @oldLevel() < @level().number
        @sound().play "userLevelUp"
        @label.transition "tada"
        @oldLevel @level().number
      else if @oldLevel() > @level().number
        @oldLevel @level().number
        @sound().play "userLevelDown"
        @label.transition "shake"
