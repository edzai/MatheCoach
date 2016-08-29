require "./moduleList.jade"
{ getModulesList } =
  require "/imports/modules/mathproblems2/getModulesList.coffee"

{ ModuleScores } = require "/imports/api/collections.coffee"
require "/imports/ui/moduleScoresDisplay/moduleScoresDisplay.coffee"

Template.moduleList.viewmodel
  modules : getModulesList()
  #showScores : false

Template.moduleListItem.viewmodel
  gotoModule : ->
    FlowRouter.go "/modul/#{@key()}"
  moduleScores : ->
    ModuleScores.findOne
      userId : Meteor.userId()
      moduleKey : @key()
