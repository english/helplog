App.LoginController = Ember.ObjectController.extend
  needs: 'application'
  actions:
    cancel: -> @set 'controllers.application.isLoggingIn', false
    login: ->
      @get('content').save().then =>
        App.set 'isLoggedIn', true
        @set 'hasError', false
        @set 'controllers.application.isLoggingIn', false
      , => @set 'hasError', true
