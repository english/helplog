Helplog.Router.reopen
  location: 'history'
  rootURL:  '/'

Helplog.Router.map ->
  @resource 'posts'
  @route    'posts.new',        path: '/posts/new'
  @resource 'post',             path: '/posts/:post_id'
  @route    'posts.edit',       path: '/posts/:post_id/edit'
  @route    'sessions.new',     path: '/sessions/new'
  @route    'sessions.destroy', path: '/sessions/destroy'

Helplog.IndexRoute = Ember.Route.extend
  redirect: -> @transitionTo 'posts'

Helplog.PostsRoute = Ember.Route.extend
  model: -> Helplog.Post.find()

Helplog.AuthenticatedRoute = Ember.Route.extend
  redirect: -> @transitionTo 'index' unless Helplog.get('isLoggedIn')

Helplog.PostsNewRoute = Helplog.AuthenticatedRoute.extend
  model: -> Helplog.Post.createRecord()

Helplog.PostsEditRoute = Helplog.AuthenticatedRoute.extend
  model: (params) -> Helplog.Post.find params.post_id

Helplog.PostRoute = Ember.Route.extend
  model: (params) -> Helplog.Post.find params.post_id

Helplog.SessionsNewRoute = Ember.Route.extend
  model: -> Helplog.Session.createRecord()
  redirect: -> @transitionTo 'index' if Helplog.get('isLoggedIn')

Helplog.SessionsDestroyRoute = Ember.Route.extend
  redirect: ->
    $.ajax
      url: '/sessions/current'
      type: 'DELETE'
      success: -> Helplog.set('isLoggedIn', false)
    @transitionTo('posts')

