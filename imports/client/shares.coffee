#NOTE: Keeping this for reference for now

_ = require "lodash"
MobileDetect = require "mobile-detect"

{ pushSubmissionToStore, removeSubmissionFromStore , flushSubmissionStore } =
  require "./localStore.coffee"

{ insertSubmission } = require "/imports/api/submissions.coffee"

{ Howl } = require "howler"

import { setLanguage } from "/imports/api/users.coffee"

import { translations } from "./translations.coffee"

ViewModel.share
  reactiveTimer :
    reactiveTimer : new ReactiveTimer(10)
    tick : -> @reactiveTimer().tick()
  FlowRouterAuth :
    permissionGranted : ->
      FlowRouter.Auth.permissionGranted()

  sound :
    sound : new Howl
      src : ["/sounds.mp3"]
      sprite :
        click : [0, 500]
        right : [1000, 2000]
        wrong : [3000, 2000]
        difficultylUp : [5000, 2000]
        difficultyDown : [8000, 2000]
        userLevelUp : [11000, 2000]
        userLevelDown : [900, 50]

  unsyncedSubmissions :
    unsyncedCount : 0
    insertSubmission : (submissionObject) ->
      inserted = insertSubmission.call submissionObject,
        (error, result) =>
          unless error
            removeSubmissionFromStore submissionObject
            @unsyncedCount @unsyncedCount() - 1
          else console.log error
      if inserted
        pushSubmissionToStore submissionObject
        @unsyncedCount @unsyncedCount() + 1

  layout :
    navbarSize : ->
      if @useMobile()
        Meteor.user()?.navbarSize or 1
      else 1
    contentSize : ->
      if @useMobile()
        Meteor.user()?.contentSize or 1
      else 1
    keypadSize : ->
      if @useMobile()
        Meteor.user()?.keypadSize or 1
      else 1
    layoutEditorToggle : false
    isMobile : ->
      (new MobileDetect window.navigator.userAgent).mobile()?
    forceUseMobile : false
    useMobile : ->
      if @forceUseMobile() then true else if @isMobile() then true
    forceUseOtherKeyboard : false
    useKeypad : ->
      if @useMobile()
        not @forceUseOtherKeyboard()
      else
        @forceUseOtherKeyboard()
    autorun : [
      ->
        document.getElementsByTagName('html')[0].style['font-size'] =
          "#{@contentSize()*100}%"
    ]

  language :
    language : -> Meteor.user()?.language or "de"
    switchLanguage : ->
      if @language() is "de"
        setLanguage.call language : "en"
      else
        setLanguage.call language : "de"
    ü : (key) -> translations[@language()][key] or "[#{key}]"

  unsolvedProblems :
    unsolvedProblems : {}
    currentLevelForModule : {}
    rememberUnsolvedProblems : true
    memorizeProblem : (moduleKey, level, problemObject, language="de") ->
      temp = @unsolvedProblems()
      temp["#{moduleKey}_#{level}_#{language}"] = problemObject
      @unsolvedProblems temp
      temp = @currentLevelForModule()
      temp[moduleKey] = level
      @currentLevelForModule temp
    recallProblem : (moduleKey, level, language="de") ->
      if @rememberUnsolvedProblems()
        @unsolvedProblems()?["#{moduleKey}_#{level}"]
      else
        undefined
    forgetProblem : (moduleKey, level) ->
      @memorizeProblem moduleKey, level, undefined
    forgetAllProblems: -> @unsolvedProblems {}
    recallLevel : (moduleKey) ->
      @currentLevelForModule()[moduleKey] or 1

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
      @timeAgoReactiveTimer().tick?()
      if @lastActive?()?
        date = moment @lastActive()
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
