Helplog.Router.map ->
  @resource 'posts'
  @route    'posts.new',    path: '/posts/new'
  @resource 'post',         path: '/posts/:post_id'
  @route    'posts.edit',   path: '/posts/:post_id/edit'
  @route    'sessions.new', path: '/sessions/new'

Helplog.IndexRoute = Ember.Route.extend
  redirect: -> @transitionTo 'posts'

Helplog.SetSession = Ember.Mixin.create
  setupController: (controller, model) ->
    controller.set 'content', model
    controller.set 'session', Helplog.Session.find('current')

Helplog.ApplicationRoute = Ember.Route.extend Helplog.SetSession

Helplog.PostsRoute = Ember.Route.extend Helplog.SetSession,
  model: -> Helplog.Post.find()

Helplog.PostsEditRoute = Ember.Route.extend
  enter: -> 
    Helplog.Session.find('current').then (session) =>
      @transitionTo 'posts' unless session.get('active')

Helplog.PostsNewRoute = Ember.Route.extend
  enter: -> 
    Helplog.Session.find('current').then (session) =>
      @transitionTo 'posts' unless session.get('active')
  model: -> Helplog.Post.createRecord()

Helplog.PostRoute = Ember.Route.extend Helplog.SetSession,
  model: (params) -> Helplog.Post.find params.post_id

Helplog.SessionsNewRoute = Ember.Route.extend
  model: -> Helplog.Session.createRecord()
