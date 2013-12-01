App.LoginController = Ember.ObjectController.extend
  needs: 'application'
  actions:
    cancel: -> @set 'controllers.application.isLoggingIn', false
    login: ->
      saving = @get('content').save()
      saving.done =>
        App.set 'isLoggedIn', true
        @set 'hasError', false
        @set 'controllers.application.isLoggingIn', false
      saving.fail => @set 'hasError', true
