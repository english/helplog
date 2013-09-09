Ember.Application.initializer
  name: 'isLoggedIn'
  initialize: ->
    attributes = $('meta[name="current-session"]').attr('content')
    if attributes
      session = JSON.parse(attributes).session
      App.set 'isLoggedIn', session.active
