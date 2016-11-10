require "./submissionsList.jade"
{ problemDefinitions } =
  require  "/imports/modules/mathproblems2/problemDefinitions.coffee"


Template.submissionsList.viewmodel

Template.submissionDisplay.viewmodel
  share : "reactiveTimer"
  timeAgo : ->
    @tick()
    date = moment(@date())
    "#{date.calendar()} (#{date.fromNow()})"
  moduleTitle : -> problemDefinitions[@moduleKey()].title
  answerSegmentClass : ->
    if @answerCorrect() then "green" else "red"
  onRendered : ->
    unless moment().diff(moment(@date()), "minutes") > 10
      @element
      .transition "hide"
      .transition "scale"
