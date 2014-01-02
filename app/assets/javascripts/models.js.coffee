if Ember.ENV.env == 'production'
  App.Store = DS.Store.extend
    adapter: DS.ActiveModelAdapter
else
  App.Store = DS.Store.extend
    adapter: DS.FixtureAdapter

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
  updatedAt: DS.attr('string')
  comments: DS.hasMany('comment', async: true)

App.Comment = DS.Model.extend
  author: DS.attr('string')
  body: DS.attr('string')
  post: DS.belongsTo('post')
