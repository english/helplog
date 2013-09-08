#Helplog.Store = DS.Store.extend
  #revision: 13
  #adapter: DS.RESTAdapter.create()

Helplog.Session = Ember.Object.extend
  save: ->
    $.post '/sessions',
      session:
        email: @get('email')
        password: @get('password')
  destroy: ->
    $.ajax
      url: '/sessions/current'
      type: 'DELETE'
  
Helplog.Post = DS.Model.extend
  title: DS.attr('string')
  intro: DS.attr('string')
  body: DS.attr('string')
  published: DS.attr('boolean')
