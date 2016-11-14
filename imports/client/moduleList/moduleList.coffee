require "./moduleList.jade"
{ getModulesList } =
  require "/imports/client/mathproblems/getModulesList.coffee"

require "/imports/client/moduleScoreDisplay/moduleScoreDisplay.coffee"

Template.moduleList.viewmodel
  modules : getModulesList()
  #showScores : false

Template.moduleListItem.viewmodel
  gotoModule : ->
    FlowRouter.go "/modul/#{@key()}"
  userId : -> Meteor.userId()
