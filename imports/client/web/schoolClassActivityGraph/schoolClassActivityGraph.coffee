require "chartist/dist/chartist.css"
require "./schoolClassActivityGraph.jade"
{moduleFilterList} = require "/imports/client/mathproblems/getModulesList.coffee"
{Submissions} = require "/imports/api/submissions.coffee"
Chartist = require "chartist"
_ = require "lodash"

Template.schoolClassActivityGraph.viewmodel
  hideSettings : true
  modules : moduleFilterList
  selectedModules : moduleFilterList.map (e) -> e.key
  selectAll : ->
    @selectedModules(moduleFilterList.map (e) -> e.key)
  selectNone : ->
    @selectedModules []
  days : 7
  incDays : -> @days @days()+1
  decDays : ->
    if @days() > 1 then @days @days()-1
  graphTitle : ->
    if @days() is 1
      "Aktivität heute"
    else
      "Aktivität in den letzten #{@days()} Tagen"
  graphDescription : ->
    if @selectedModules().length is @modules().length
      "Alle Module"
    else
      moduleList = _(@modules())
      .filter (module) => module.key in @selectedModules()
      .map (module) -> module.title
      .value().join(", ")
      "Module : #{moduleList}"
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
  onRendered : ->
    $(".ui.accordion").accordion()
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
