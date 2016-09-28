require "./submissionsList.jade"
{ problemDefinitions } =
  require  "/imports/modules/mathproblems2/problemDefinitions.coffee"


Template.submissionsList.viewmodel

Template.submissionDisplay.viewmodel
  share : "reactiveTimer"
  timeAgo : ->
    @tick()
    moment(@date()).fromNow()
  moduleTitle : -> problemDefinitions[@moduleKey()].title
  answerSegmentClass : ->
    if @answerCorrect() then "green" else "red"
