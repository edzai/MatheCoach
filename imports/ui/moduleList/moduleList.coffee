require "./moduleList.jade"
{ getModulesList } =
  require "/imports/modules/mathproblems2/getModulesList.coffee"

require "/imports/ui/moduleScoreDisplay/moduleScoreDisplay.coffee"

Template.moduleList.viewmodel
  modules : getModulesList()
  #showScores : false

Template.moduleListItem.viewmodel
  gotoModule : ->
    FlowRouter.go "/modul/#{@key()}"
  userId : -> Meteor.userId()
