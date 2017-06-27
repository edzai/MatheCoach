require "./moduleScoreDisplay.jade"

{ Tally } =
  require "/imports/modules/tally.coffee"

Template.moduleScoreDisplay.viewmodel
  share : "reactiveTimer"
  eightWeeksAgo : ->
    @tick()
    moment().subtract(14, "days").toDate()
  tally : ->
    new Tally
      userId : @userId() ? Meteor.userId()
      moduleKey : @moduleKey()
      date :
        $gt : @eightWeeksAgo()
  score : -> @tally().score()
