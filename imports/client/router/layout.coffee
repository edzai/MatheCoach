require "./layout.jade"

Template.layout.viewmodel
  share : "layout"

Template.web.viewmodel
  share : "layout"
  paddingTop : -> "#{@navbarSize() * 20}px"

Template.mobile.viewmodel
  share : "layout"
  paddingTop : -> "#{@navbarSize() * 48 + 10}px"

Template.footer.viewmodel
  share : "layout"
  viewportSize : ->
    "#{window.innerWidth} x #{window.innerHeight}"
