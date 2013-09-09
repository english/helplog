App.Router.reopen
  location: 'history'
  rootURL:  '/'

App.Router.map ->
  @resource 'posts'
  @route    'posts.new',  path: '/posts/new'
  @resource 'post',       path: '/posts/:post_id'
  @route    'posts.edit', path: '/posts/:post_id/edit'

App.ApplicationRoute = Ember.Route.extend
  setupController: -> @controllerFor('login').set 'content', App.Session.create()

App.IndexRoute = Ember.Route.extend
  redirect: -> @transitionTo 'posts'

App.PostsRoute = Ember.Route.extend
  model: -> @get('store').find 'post'

App.AuthenticatedRoute = Ember.Route.extend
  redirect: -> @transitionTo 'index' unless App.get 'isLoggedIn'

App.PostsNewRoute = App.AuthenticatedRoute.extend
  model: -> @store.createRecord 'post'
  renderTemplate: -> @render 'posts/form'

App.PostsEditRoute = App.AuthenticatedRoute.extend
  model: (params) -> @get('store').find 'post', params.post_id
  renderTemplate: -> @render 'posts/form'

App.PostRoute = Ember.Route.extend
  model: (params) -> @get('store').find 'post', params.post_id
