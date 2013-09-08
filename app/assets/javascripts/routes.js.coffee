Helplog.Router.reopen
  location: 'history'
  rootURL:  '/'

Helplog.Router.map ->
  @resource 'posts'
  @route    'posts.new',  path: '/posts/new'
  @resource 'post',       path: '/posts/:post_id'
  @route    'posts.edit', path: '/posts/:post_id/edit'

Helplog.ApplicationRoute = Ember.Route.extend
  setupController: -> @controllerFor('login').set 'content', Helplog.Session.create()

Helplog.IndexRoute = Ember.Route.extend
  redirect: -> @transitionTo 'posts'

Helplog.PostsRoute = Ember.Route.extend
  model: -> @get('store').find 'post'

Helplog.AuthenticatedRoute = Ember.Route.extend
  redirect: -> @transitionTo 'index' unless Helplog.get 'isLoggedIn'

Helplog.PostsNewRoute = Helplog.AuthenticatedRoute.extend
  model: -> @get('store').createRecord 'post'
  renderTemplate: -> @render 'posts/form'

Helplog.PostsEditRoute = Helplog.AuthenticatedRoute.extend
  model: (params) -> @get('store').find 'post', params.post_id
  renderTemplate: -> @render 'posts/form'

Helplog.PostRoute = Ember.Route.extend
  model: (params) -> @get('store').find 'post', params.post_id
