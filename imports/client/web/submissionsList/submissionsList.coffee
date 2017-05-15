require "./submissionsList.jade"
require "/imports/client/web/renderSVG/renderSVG.coffee"
require "/imports/client/web/renderFunctionTemplate/\
  renderFunctionTemplate.coffee"
{ problemDefinitions } =
  require  "/imports/client/mathproblems/problemDefinitions.coffee"


Template.submissionsList.viewmodel

Template.submissionDisplay.viewmodel
  share : "reactiveTimer"
  timeAgo : ->
    @tick()
    date = moment(@date())
    "#{date.calendar()} (#{date.fromNow()})"
  moduleTitle : -> problemDefinitions[@moduleKey()].title
  drawSVG : -> @SVGData?
  drawFunctionPlot : -> @functionData?
  answerSegmentClass : ->
    if @answerCorrect() then "green" else "red"
  onRendered : ->
    unless moment().diff(moment(@date()), "minutes") > 10
      @element
      .transition "hide"
      .transition "scale"
