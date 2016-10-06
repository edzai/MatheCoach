require "./moduleScoreDisplay.jade"

{ Tally } =
  require "/imports/modules/tally.coffee"

Template.moduleScoreDisplay.viewmodel
  share : "reactiveTimer"
  twoWeeksAgo : ->
    @tick()
    moment().subtract(14, "days").toDate()
  tally : ->
    new Tally
      userId : @userId() ? Meteor.userId()
      moduleKey : @moduleKey()
      date :
        $gt : @twoWeeksAgo()
  score : -> @tally().score()
