Helplog.Router.reopen
  location: 'history'
  rootURL:  '/'

Helplog.Router.map ->
  @resource 'posts'
  @route    'posts.new',        path: '/posts/new'
  @resource 'post',             path: '/posts/:post_id'
  @route    'posts.edit',       path: '/posts/:post_id/edit'

Helplog.ApplicationRoute = Ember.Route.extend
  setupController: -> @controllerFor('login').set 'content', Helplog.Session.create()

Helplog.IndexRoute = Ember.Route.extend
  redirect: -> @transitionTo 'posts'

Helplog.PostsRoute = Ember.Route.extend
  model: -> Helplog.Post.find()

Helplog.AuthenticatedRoute = Ember.Route.extend
  redirect: -> @transitionTo 'index' unless Helplog.get 'isLoggedIn'

Helplog.PostsNewRoute = Helplog.AuthenticatedRoute.extend
  model: -> Helplog.Post.createRecord()
  renderTemplate: -> @render 'posts/form'

Helplog.PostsEditRoute = Helplog.AuthenticatedRoute.extend
  model: (params) -> Helplog.Post.find params.post_id
  renderTemplate: -> @render 'posts/form'

Helplog.PostRoute = Ember.Route.extend
  model: (params) -> Helplog.Post.find params.post_id

Helplog.SessionsNewRoute = Ember.Route.extend
  model: -> Helplog.Session.createRecord()
  redirect: -> @transitionTo 'index' if Helplog.get('isLoggedIn')
