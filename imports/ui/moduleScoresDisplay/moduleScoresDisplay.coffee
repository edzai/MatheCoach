require "./moduleScoresDisplay.jade"

Template.moduleScoresDisplay.viewmodel
  rightPercent : ->
    unless @answeredCount() is 0
      percent = Math.round(@rightCount() / @answeredCount() * 100)
      "Das sind #{percent}%."
    else
      ""
  answeredCount : -> @rightCount() + @wrongCount()
  quotientText : -> " Du hast #{@rightCount()} von \
    #{@answeredCount()} Aufgaben richtig beantwortet. \
    #{@rightPercent()}"
  streakText : ->
    if @streak() > 1
      "Du hast #{@streak()} Aufgaben hintereinander richtig beantwortet."
    else
      ""
