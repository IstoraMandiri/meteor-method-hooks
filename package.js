Package.describe({
  summary: 'Provides before/after hooks for Meteor methods',
  version: '1.1.0',
  name: 'hitchcott:method-hooks',
  git: 'https://github.com/hitchcott/meteor-method-hooks'
});

Package.on_use(function (api) {
  if(api.versionsFrom) {
    api.versionsFrom('METEOR@0.9.0');
  }

  api.use([
    'coffeescript'
  ], ['server']);

  api.add_files([
    'method-hooks.coffee'
  ], ['server']);

});
