require "chartist/dist/chartist.css"
require "./schoolClassActivityGraph.jade"
{ Submissions } = require "/imports/api/submissions.coffee"
Chartist = require "chartist"
_ = require "lodash"

Template.schoolClassActivityGraph.viewmodel
  graphId : -> "graph-#{@_id()}"
  students : ->
    Meteor.users.find
      "schoolClassId" : @_id()
    ,
      sort :
        "profile.lastName" : 1
        "profile.firstName" : 1
  submissions : ->
    studentIds = @students().fetch().map (student) -> student._id
    Submissions.find
      userId :
        $in : studentIds
  chartData : ->
    daysAgo = 7
    submissions = @submissions().fetch()
    students = @students().fetch()
    startDate = moment().subtract(daysAgo, "days")
    labels = []
    series1 = []
    series2 = []
    for student in students
      labels.push "#{student.profile.firstName} \
        #{student.profile.lastName}"
      studentSubmissions =
        _(submissions)
        .filter userId : student._id
        .filter (submission) ->
          moment(submission.date).isAfter startDate
        .countBy (submission) -> submission.answerCorrect
        .value()
      series1.push studentSubmissions[true] ? 0
      series2.push studentSubmissions[false] ? 0
    #return
    labels : labels
    series : [series1, series2]
  autorun : ->
    new Chartist.Bar "##{@graphId()}", @chartData(),
      stackBars : true
      horizontalBars : true,
      axisX :
        onlyInteger : true
      axisY :
        offset : 80
