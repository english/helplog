App.Store = DS.Store.extend()

App.Session = Ember.Object.extend
  save: ->
    $.post '/sessions',
      session:
        email: @get('email')
        password: @get('password')
  destroy: ->
    $.ajax
      url: '/sessions/current'
      type: 'DELETE'
  
App.Post = DS.Model.extend
  title: DS.attr('string')
  intro: DS.attr('string')
  body: DS.attr('string')
  published: DS.attr('boolean')
