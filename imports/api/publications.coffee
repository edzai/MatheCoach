{ Submissions } = require "/imports/api/submissions.coffee"
{ SchoolClasses } = require "/imports/api/schoolClasses.coffee"
{ ChatMessages } = require "/imports/api/chatMessages.coffee"

if Meteor.isServer
  #TODO: add publication for current user data
  Meteor.publish "userData", ->
    if @userId
      Meteor.users.find _id : @userId
    else
      @ready()

  Meteor.publish "mentorData", ->
    Roles.getUsersInRole("mentor")

  Meteor.publishComposite "allUserData", ->
    find : ->
      if Roles.userIsInRole @userId, "admin"
        Meteor.users.find()
      else
        @ready()

  Meteor.publish "schoolClasses", ->
    SchoolClasses.find()

  Meteor.publish "userSubmissions", ->
    unless @userId
      @ready()
    else
      Submissions.find userId : @userId

  Meteor.publishComposite "studentSubmissions", ->
    find : ->
      Meteor.users.find
        _id : @userId
      ,
        fields :
          username : 1
          profile : 1
          emails : 1
          useKaTeX : 1
          navbarSize : 1
          contentSize : 1
          keypadSize : 1
          schoolClassId : 1
    children : [
      find : (teacher) ->
        SchoolClasses.find
          teacherId : teacher._id
        ,
          fields :
            name : 1
            teacherId : 1
      children : [
        find : (schoolClass) ->
          Meteor.users.find
            "schoolClassId" : schoolClass._id
          ,
            fields :
              username : 1
              profile : 1
              emails : 1
              schoolClassId : 1
              lastActive : 1
        children : [
          find : (student) ->
            Submissions.find userId : student._id
        ]
      ]
    ]

  Meteor.publishComposite "chatMessages", ->
    find : ->
      if @userId?
        ChatMessages.find
          $or :
            [
              receiverId : @userId
            ,
              senderId : @userId
            ]

if Meteor.isClient
  #userData is subscribed to in layout template
  Meteor.subscribe "userData"
  Tracker.autorun ->
    if Roles.userIsInRole @Meteor.userId(), "mentor"
      Meteor.subscribe "studentSubmissions"
  Tracker.autorun ->
    if Roles.userIsInRole @Meteor.userId(), "admin"
      Meteor.subscribe "allUserData"
  Tracker.autorun ->
    if @Meteor.user()
      exports.userDataSubscription = Meteor.subscribe "userData"
      Meteor.subscribe "mentorData"
      Meteor.subscribe "schoolClasses"
      exports.userSubmissionsSubscription = Meteor.subscribe "userSubmissions"
      exports.chatMessagesSubscription = Meteor.subscribe "chatMessages"
