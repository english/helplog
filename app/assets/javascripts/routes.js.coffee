Helplog.Router.reopen
  location: 'history'
  rootURL: '/'

Helplog.Router.map ->
  @resource 'posts'
  @route    'posts.new',        path: '/posts/new'
  @resource 'post',             path: '/posts/:post_id'
  @route    'posts.edit',       path: '/posts/:post_id/edit'
  @route    'sessions.new',     path: '/sessions/new'
  @route    'sessions.destroy', path: '/sessions/destroy'

Helplog.ApplicationRoute = Ember.Route.extend
  setupController: -> @controller.set 'session', Helplog.Session.find('current')

Helplog.IndexRoute = Ember.Route.extend
  redirect: -> @transitionTo 'posts'

Helplog.PostsRoute = Ember.Route.extend
  model: -> Helplog.Post.find()

Helplog.PostsNewRoute = Ember.Route.extend
  model: -> Helplog.Post.createRecord()

Helplog.PostRoute = Ember.Route.extend
  model: (params) -> Helplog.Post.find params.post_id

Helplog.SessionsNewRoute = Ember.Route.extend
  redirect: ->
    Helplog.Session.find('current').then (session) =>
      @transitionTo 'index' if session.get('active')

  model: -> Helplog.Session.createRecord()

Helplog.SessionsDestroyRoute = Ember.Route.extend
  redirect: ->
    $.ajax
      url: '/sessions/current'
      type: 'DELETE'
      success: => @controllerFor('application').set('session.active', false)

    @transitionTo('posts')
