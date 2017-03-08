require "./checkmarkToggle.jade"

Template.checkmarkToggle.viewmodel
  checked : true
  label : "test bestanden"

Template.checkmarkToggleTest.viewmodel
  bestanden : true
  nichtBestanden : -> not @bestanden()
  click : -> alert "click"
