_ = require "lodash"
MobileDetect = require "mobile-detect"

{ pushToStore, removeFromStore , flushStore } =
  require "./localStore.coffee"

{ insertSubmission } = require "/imports/api/submissions.coffee"

ViewModel.share
  reactiveTimer :
    reactiveTimer : new ReactiveTimer(10)
    tick : -> @reactiveTimer().tick()
  FlowRouterAuth :
    permissionGranted : ->
      FlowRouter.Auth.permissionGranted()
  unsyncedSubmissions :
    unsyncedCount : 0
    insertSubmission : (submissionObject) ->
      inserted = insertSubmission.call submissionObject,
        (error, result) =>
          unless error
            removeFromStore submissionObject
            @unsyncedCount @unsyncedCount() - 1
          else console.log error
      if inserted
        pushToStore submissionObject
        @unsyncedCount @unsyncedCount() + 1

  layout :
    navbarSize : 1#-> Meteor.user()?.profile?.navbarSize or 1
    contentSize : 1#-> Meteor.user()?.profile?.contentSize or 1
    keypadSize : 1#-> Meteor.user()?.profile?.keypadSize or 1
    showViewportSize : -> Meteor.user()?.profile?.showViewportSize or false
    layoutEditorToggle : false
    isMobile : ->
      md = new MobileDetect window.navigator.userAgent
      console.log md
      console.log "mobile", md.mobile()
      md.mobile()?
    forceUseMobile : false
    useMobile : ->
      if @forceUseMobile() then true else if @isMobile() then true
    forceUseKeyboard : false
    useKeypad : ->
      if @forceUseKeyboard() then false else if @useMobile() then true
    autorun : [
      ->
        document.body.style.zoom = "#{@contentSize()*100}%"
    ]

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

  timeAgo :
    timeAgoReactiveTimer : new ReactiveTimer(10)
    timeAgo : ->
      @timeAgoReactiveTimer().tick()
      if @profile?().lastActive?
        date = moment(@profile().lastActive)
        "#{date.calendar()} (#{date.fromNow()})"
      else
        "(bisher noch nicht aktiv)"

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
