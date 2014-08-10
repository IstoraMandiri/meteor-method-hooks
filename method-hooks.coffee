methodHooks = {}

registerMethodHook = (methodNames, position, fn) ->
  # accept array or string
  methodNames = [methodNames] unless methodNames instanceof Array
  for methodName in methodNames
    methodHooks[methodName]?=
      before: []
      after: []
    # use unshift so they get executed in the correct order after wrapping
    methodHooks[methodName][position].unshift fn

# Extend Meteor API
Meteor.beforeMethods = (methodName, fn) ->
  registerMethodHook methodName, 'before', fn

Meteor.afterMethods = (methodName, fn) ->
  registerMethodHook methodName, 'after', fn

# modified from stackoverflow.com/a/5259530/2682159
wrap = (fn, beforeFn) ->
  ->
    args = Array::slice.call(arguments)
    beforeResult = beforeFn.apply this, args
    if beforeResult is false
      # stop execution queue if the result is false
      return false
    else
      fn.apply this, args

# Begin wrapping process once app is started
Meteor.startup ->
  # Cycle through registered methodHooks
  for method, hooks of methodHooks
    wrappedMethod = Meteor.server.method_handlers[method]

    # Wrap in the relevent positions, multiple
    for beforeHook in hooks.before
      wrappedMethod = wrap wrappedMethod, beforeHook
    for afterHook in hooks.after
      wrappedMethod = wrap afterHook, wrappedMethod

    # Overrite raw method with wrapped method
    Meteor.server.method_handlers[method] = wrappedMethod
