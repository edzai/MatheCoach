require "./layout.jade"
{ userDataSubscription } = require "/imports/api/publications.coffee"

Template.layout.viewmodel
  share : "layout"

Template.web.viewmodel
  share : "layout"
  loading : -> not @templateInstance.subscriptionsReady()
  paddingTop : -> "#{@navbarSize() * 20}px"
  autorun : [
    -> @templateInstance.subscribe "userData"
    -> console.log "loading", @loading()
  ]

Template.mobile.viewmodel
  share : "layout"
  paddingTop : -> "#{@navbarSize() * 48 + 10}px"

Template.footer.viewmodel
  share : "layout"
  viewportSize : ->
    "#{window.innerWidth} x #{window.innerHeight}"
