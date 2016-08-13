require "./moduleScoresDisplay.jade"

Template.moduleScoresDisplay.viewmodel
  answeredCount : -> @rightCount() + @wrongCount()
  percentText : ->
    unless @answeredCount() is 0
      percent = Math.round(@rightCount() / @answeredCount() * 100)
      " = #{percent}%"
    else
      ""
  rightText : ->
    "#{@rightCount()}#{@percentText()}"
  rightTooltip : ->
    "Du hast #{@rightCount()} von #{@answeredCount()} Aufgaben \
    richtig Beantwortet."
  streakTooltip : ->
    "Du hast #{@streak()} Aufgaben hintereinander richtig Beantwortet."
