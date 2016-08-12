require "./moduleList.jade"
{ getModulesList } =
  require "/imports/modules/mathproblems2/getModulesList.coffee"

Template.moduleList.viewmodel
  modules : getModulesList()

Template.moduleListItem.viewmodel
  gotoModule : ->
    FlowRouter.go "/modul/#{@key()}"
