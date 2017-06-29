require "./setLayout.jade"
{ setLayout } = require "/imports/api/users.coffee"

Template.setLayout.viewmodel
  share : "layout"
  adjust : (property, operation) ->
    setLayout.call { property, operation }
  autorun : ->
    if @layoutEditorToggle()
      @layoutEditor.modal
        closeable : true
        dimmerSettings :
          opacity : 0.6
        onHide : =>
          @layoutEditorToggle(false)
          true
      @layoutEditor.modal "show"
