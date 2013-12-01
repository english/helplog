attributes = -> $('meta[name="current-session"]').attr 'content'

Ember.Application.initializer
  name: 'isLoggedIn'
  initialize: ->
    if attributes()
      session = JSON.parse(attributes()).session
      App.set 'isLoggedIn', session.active
