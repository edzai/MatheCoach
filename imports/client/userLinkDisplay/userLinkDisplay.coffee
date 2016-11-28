require "./userLinkDisplay.jade"

Template.userLinkDisplay.viewmodel
  userData : -> Meteor.users.findOne _id : @userId()
  userName : -> @userData()?.fullName()
  userType : ->
    switch @userData()?.profile?.userType
      when "mentor" then "Lehrer(in)"
      when "parent" then "Erziehungsberechtigte(r)"
      else ""
  email : -> @userData()?.emails[0].address
  url : -> "/benutzer-daten/#{@userId()}"
  mailto : -> "mailto:#{@email()}"
