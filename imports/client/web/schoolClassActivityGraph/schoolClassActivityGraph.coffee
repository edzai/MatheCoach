require "chartist/dist/chartist.css"
require "./schoolClassActivityGraph.jade"
{moduleFilterList} =
  require "/imports/client/mathproblems/getModulesList.coffee"
{Submissions} = require "/imports/api/submissions.coffee"
{ ActivityGraphs, updateActivityGraph, removeActivityGraph} =
  require "/imports/api/activityGraphs.coffee"
Chartist = require "chartist"
_ = require "lodash"
{ EJSON } = require "meteor/ejson"

Template.schoolClassActivityGraphSettings.viewmodel
  modules : ->
    if @selectedModules?()?
      moduleFilterList.map (e) =>
        e.selected = (e.key in @selectedModules().array())
        e
  selectAll : ->
    updateActivityGraph.call
      id : @_id()
      selectedModules : moduleFilterList.map (e) -> e.key
  selectNone : ->
    updateActivityGraph.call
      id : @_id()
      selectedModules : []
  toggleModule : (key) ->
    selectedModules = @selectedModules?()?.array()
    updateActivityGraph.call
      id : @_id()
      selectedModules :
        if key in selectedModules
          _.filter selectedModules, (e) -> e isnt key
        else
          selectedModules.concat key
  incDays : ->
    updateActivityGraph.call
      id : @_id()
      days : @days()+1
  decDays : ->
    if @days() > 1
      updateActivityGraph.call
        id : @_id()
        days : @days()-1
  removePlot : ->
    $(".ui.basic.modal##{@_id()}")
    .modal
      onApprove : =>
        removeActivityGraph.call id : @_id()
    .modal("show")
  days : 7

Template.schoolClassActivityGraph.viewmodel
  hideSettings : true
  #selectedModules : moduleFilterList.map (e) -> e.key
  settings : ->
    _id : @_id()
    selectedModules : @selectedModules()
    days : @days()
  graphTitle : ->
    if @days() is 1
      "Aktivität heute"
    else
      "Aktivität in den letzten #{@days()} Tagen"
  graphDescription : ->
    if @selectedModules().length is moduleFilterList.length
      "Alle Module"
    else
      moduleList = _(moduleFilterList)
      .filter (module) => module.key in @selectedModules()
      .map (module) -> module.title
      .value().join(", ")
      "Module : #{moduleList}"
  graphId : -> "graph-#{@_id()}"
  students : ->
    Meteor.users.find
      "schoolClassId" : @schoolClassId()
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
    daysAgo = @days()
    selectedModules = @selectedModules()
    submissions = @submissions().fetch()
    students = @students().fetch()
    startDate = moment().subtract(daysAgo, "days")
    labels = []
    series1 = []
    series2 = []
    for student in students
      labels.push "#{student.profile?.firstName} \
        #{student.profile?.lastName}"
      studentSubmissions =
        _(submissions)
        .filter userId : student._id
        .filter (submission) ->
          moment(submission.date).isAfter startDate
        .filter (submission) ->
          submission.moduleKey in selectedModules
        .countBy (submission) -> submission.answerCorrect
        .value()
      series1.push studentSubmissions[true] ? 0
      series2.push studentSubmissions[false] ? 0
    #return
    labels : labels
    series : [series1, series2]
  autorun : [
    ->
      new Chartist.Bar "##{@graphId()}", @chartData(),
        stackBars : true
        horizontalBars : true,
        axisX :
          onlyInteger : true
        axisY :
          offset : 80
    ]
