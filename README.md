# Meteor Method Hooks
### Before/after hooks for Meteor methods

This package is old and hasn't been maintained in a while. Try this one, which has tests and is more recent: https://github.com/Workpop/meteor-method-hooks

| Meteor >= 0.9  | Meteor < 0.9  |
|---|---|
|  `meteor add hitchcott:method-hooks`  |  `mrt add method-hooks` |


This server-only package extends Meteor with two methods:
* `Meteor.beforeMethods` 
* `Meteor.afterMethods`

The `beforeMethods` method can be used for securing `Meteor.methods` based on the result of a definable function.

Here's an example for security, in `/server/methods.coffee`

```coffeescript
Meteor.beforeMethods 'test', ->
  Meteor.users.findOne(@userId)?.admin
```

The above will prevent the `test` method from being executed unless the client is logged in as and has their `admin` field set to `true`. 

Any `beforeMethods` that return `false` will stop the relevent method and any other hooks from executing.

Uses include:

* Security
* Logging
* [insert imaginative idea]

## Example Usage

You can pass an array of method names, and the hooks will recieve the same parameters as the original method. For example:

```coffeescript
if Meteor.isServer
  Meteor.methods
    'test1' : (str) -> console.log 'Hi', str
    'test2' : -> console.log 'second method'

  Meteor.beforeMethods ['test1','test2'], (str) ->
    console.log 'hook1', str

  Meteor.beforeMethods 'test1', ->
    console.log 'hook2'

  Meteor.afterMethods 'test2', ->
    console.log 'hook3'

if Meteor.isClient
  Meteor.call 'test1', 'Chris'
  Meteor.call 'test2'
```

will output

```
hook1 Chris
hook2
Hi Chris
hook1 undefined
second method
hook3
```

## TODO

* Testing
* `beforeAllMethods` & `afterAllMethods` ?
* Hook up methods instantly (if they exist) rather than waiting for startup, and defer any unmatched hooks until *after* `Meteor.startup`.

## Credits

[Chris Hitchcott](http://github.com/hitchcott), 2014
