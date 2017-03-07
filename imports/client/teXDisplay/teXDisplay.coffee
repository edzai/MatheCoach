katex = require "katex"
require "katex/dist/katex.min.css"
require "./teXDisplay.jade"

Template.teXDisplay.viewmodel
  #teX : String with TeX to display
  useKaTeX : ->
    Meteor.user()?.useKaTeX
  kaTeXHtml : ->
    katex.renderToString @teX(),
      displayMode : true
      throwOnError : false
