require "./renderFunctionTemplate.jade"
window.d3 = require "d3"
functionPlot = require "function-plot"

Template.renderFunctionTemplate.viewmodel
  functionId : ""
  functionPlotData : {}
  functionPlotOptions : ->
    options = @functionPlotData()
    options.target = "##{@functionId()}"
    options.width = 240
    options.height = 240
    options.disableZoom = true
    options
  onRendered : ->
    functionPlot @functionPlotOptions()
  autorun : -> functionPlot @functionPlotOptions()
