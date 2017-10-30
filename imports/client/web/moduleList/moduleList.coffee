require "./moduleList.jade"
{ getModulesList } =
  require "/imports/client/mathproblems/getModulesList.coffee"

require "/imports/client/web/moduleScoreDisplay/moduleScoreDisplay.coffee"

Template.moduleList.viewmodel
  share : ["language"]
  modules : -> getModulesList @language()

Template.moduleSubList.viewmodel
  modules : {}

Template.moduleListItem.viewmodel
  gotoModule : ->
    FlowRouter.go "/modul/#{@moduleKey()}"
  userId : -> Meteor.userId()
  listType : ->
    if @kindred()?[0]?.moduleKey?
      "ui relaxed ordered selection list"
    else
      "ui relaxed ordered celled list"
