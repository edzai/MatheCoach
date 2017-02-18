require "./layout.jade"

Template.footer.viewmodel
  share : "layout"
  viewportSize : ->
    "#{window.innerWidth} x #{window.innerHeight}"
