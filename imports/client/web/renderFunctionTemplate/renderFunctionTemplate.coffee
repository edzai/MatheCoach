require "./renderFunctionTemplate.jade"
_ = require "lodash"
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
    _.cloneDeep options
  onRendered : ->
    functionPlot @functionPlotOptions()
  autorun : -> functionPlot @functionPlotOptions()
