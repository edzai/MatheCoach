require "chartist/dist/chartist.css"
require "./activityGraph.css"
require "./activityGraph.jade"
{ Submissions } = require "/imports/api/submissions.coffee"
Chartist = require "chartist"
_ = require "lodash"

Template.activityGraph.viewmodel
  submissions : ->
    Submissions.find
      userId : @userId()
  chartData : ->
    labelFormat = "D.M."
    submissions =
      @submissions().fetch()
      .map (submission) ->
        date :
          moment(submission.date)
          .startOf("day")
          .format(labelFormat)
        answerCorrect : submission.answerCorrect
    labels = []
    series1 = []
    series2 = []
    for daysAgo in [15..0]
      date =
        moment()
        .subtract(daysAgo, "days")
        .startOf("day")
        .format(labelFormat)
      submissionsThatDay =
        _(submissions)
        .filter date : date
        .countBy (submission) -> submission.answerCorrect
        .value()
      labels.push date
      series1.push submissionsThatDay[true] ? 0
      series2.push submissionsThatDay[false] ? 0
    labels : labels
    series : [series1, series2]
  autorun : ->
    console.log @chartData()
    new Chartist.Bar ".ct-chart", @chartData(),
      stackBars : true
      axisY :
        onlyInteger : true
