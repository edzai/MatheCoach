require "./setLayout.jade"

Template.setLayout.viewmodel
  share : "layout"
  adjust : (item, op) ->
    prop = switch item
      when "navbar" then @navbarSize
      when "content" then @contentSize
      else @keypadSize
    switch op
      when "+" then prop prop() * 1.1
      when "-" then prop prop() / 1.1
      when "reset" then prop 1
  autorun : ->
    if @layoutEditorToggle()
      @layoutEditor.modal
        closeable : true
        onHide : =>
          @layoutEditorToggle(false)
          true
      @layoutEditor.modal "show"
