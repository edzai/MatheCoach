ViewModel.share
  reactiveTimer :
    reactiveTimer : new ReactiveTimer(10)
    tick : -> @reactiveTimer().tick()
