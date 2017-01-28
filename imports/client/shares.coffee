_ = require "lodash"

ViewModel.share
  reactiveTimer :
    reactiveTimer : new ReactiveTimer(10)
    tick : -> @reactiveTimer().tick()
  FlowRouterAuth :
    permissionGranted : ->
      FlowRouter.Auth.permissionGranted()

ViewModel.mixin
  rolesForUserId :
    #viewmodel must provide
    userId : ""
    #provided by this mixin:
    isMentor : -> Roles.userIsInRole @userId(), "mentor"
    isParent : -> Roles.userIsInRole @userId(), "parent"
    isAdmin : -> Roles.userIsInRole @userId(), "admin"
    isSuperAdmin : -> Roles.userIsInRole @userId(), "superAdmin"
    isStudent : -> not @isMentor() and not @isParent() and not @isAdmin()
    mayNotEditOwnProfile : ->
      Roles.userIsInRole @userId(), "mayNotEditOwnProfile"
    currentUserMayEditProfile : ->
      (Roles.userIsInRole Meteor.userId(), "admin") or
      (@userId() is Meteor.userId() and not @mayNotEditOwnProfile())

  docHandler :
    #must be defined in viewmodel:
    docHandlerSchema : {} #the simpleSchema of the doc
    docHandlerDoc : -> #the data that is getting fed into the VM
    #supplied by docHandler:
    docHandlerVMDoc : ->
      doc = {}
      data = @data()
      schemaKeys = (key for key, value of @docHandlerSchema()._schema)
      for key, value of data when key in schemaKeys
        doc[key] = value
      doc
    docHandlerVMChanged : ->
      changed = false
      vmDoc = @docHandlerVMDoc()
      doc = @docHandlerDoc()
      for key, value of vmDoc
        unless _.isEqual value, doc?[key]
          unless value is "" and doc?[key] is undefined
            changed = true
      changed
