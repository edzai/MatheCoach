require "./renderFunctionTemplate.jade"
window.d3 = require "d3"
functionPlot = require "function-plot"

Template.renderFunctionTemplate.viewmodel
  functionId : ""
  functionPlotData : {}
  functionPlotOptions : ->
    console.log "renderFunction.functionPlotOptions"
    options = @functionPlotData()
    options.target = "##{@functionId()}"
    options.width = 240
    options.height = 240
    options.disableZoom = true
    console.log options
    options
  onRendered : ->
    console.log "renderFunction.onRendered"
    functionPlot @functionPlotOptions()
  autorun : -> functionPlot @functionPlotOptions()
