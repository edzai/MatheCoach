_ = require "lodash"

ViewModel.share
  reactiveTimer :
    reactiveTimer : new ReactiveTimer(10)
    tick : -> @reactiveTimer().tick()

ViewModel.mixin
  docHandler :
    #must be defined in viewmodel:
    docHandlerSchema : {} #the simpleSchema of the doc
    docHandlerDoc : -> #the data that is getting fed into the VM
    #supplied by docHandler:
    docHandlerVMDoc : ->
      doc = {}
      data = @data()
      schemaKeys = (key for key, value of @docHandlerSchema()._schema)
      for key, value of data when key in schemaKeys
        doc[key] = value
      doc
    docHandlerVMChanged : ->
      changed = false
      vmDoc = @docHandlerVMDoc()
      doc = @docHandlerDoc()
      console.log "docHanlerVMChanged starting"
      for key, value of vmDoc
        unless _.isEqual value, doc[key]
          unless value is "" and doc[key] is undefined
            changed = true
      changed
