App.ApplicationController = Ember.Controller.extend
  isLoggedInBinding: 'App.isLoggedIn'
  actions:
    showLoginForm: -> @set 'isLoggingIn', true
    logout: ->
      App.Session.create().destroy().then -> App.set 'isLoggedIn', false
