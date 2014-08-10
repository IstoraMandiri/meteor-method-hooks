Package.describe({
  summary: 'Provides before/after hooks for Meteor methods'
});

Package.on_use(function (api) {
  api.use([
    'coffeescript'
  ], ['server']);

  api.add_files([
    'method-hooks.coffee'
  ], ['server']);

});
