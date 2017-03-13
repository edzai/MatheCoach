require "./systemMessages.jade"

{ flushSubmissionStore } =
  require "/imports/client/localStore.coffee"

Template.systemMessages.viewmodel
  share : "unsyncedSubmissions"
  profileIncomplete : ->
    Meteor.userId() and not Meteor.user()?.profile?.firstName? and
    FlowRouter.getRouteName() isnt "userSettings"

  unsyncedSubmissionsWarningPending : false
  unsyncedSubmissionsWarningTimer : ""
  unsyncedSubmissionsWarning : false
  autorun : [
    ->
      if @unsyncedCount() > 0
        unless @unsyncedSubmissionsWarningPending.value
          @unsyncedSubmissionsWarningPending true
          timer = Meteor.setTimeout (=> @unsyncedSubmissionsWarning true), 10000
          @unsyncedSubmissionsWarningTimer timer
      else
        if @unsyncedCount() is 0
          if @unsyncedSubmissionsWarningPending.value
            Meteor.clearTimeout @unsyncedSubmissionsWarningTimer()
          @unsyncedSubmissionsWarningPending false
          @unsyncedSubmissionsWarning false
          submissions = flushSubmissionStore()
          for submissionObject in submissions
            @insertSubmission submissionObject
    # ->
    #   console.log "unsyncedCount", @unsyncedCount()
    # ->
    #   console.log  "unsyncedSubmissionsWarning", @unsyncedSubmissionsWarning()
    # ->
    #   console.log "unsyncedSubmissionsWarningPending", @unsyncedSubmissionsWarningPending()
  ]
