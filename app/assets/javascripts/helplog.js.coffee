window.Helplog = Ember.Application.create LOG_TRANSITIONS: true

Helplog.Store = DS.Store.extend
  revision: 13
  adapter: DS.RESTAdapter.create()

Helplog.Session = DS.Model.extend active: DS.attr('boolean')

Helplog.Post = DS.Model.extend
  title: DS.attr('string')
  body: DS.attr('string')
  published: DS.attr('boolean')

Helplog.Router.map ->
  @resource 'posts'
  @route    'posts.new',  path: '/posts/new'
  @resource 'post',       path: '/posts/:post_id'
  @route    'posts.edit', path: '/posts/:post_id/edit'

Helplog.IndexRoute = Ember.Route.extend
  redirect: -> @transitionTo 'posts'

Helplog.SetSession = Ember.Mixin.create
  setupController: (controller, model) ->
    controller.set 'content', model
    controller.set 'session', Helplog.Session.find(1)

Helplog.PostsRoute = Ember.Route.extend Helplog.SetSession,
  model: -> Helplog.Post.find()

Helplog.PostsNewRoute = Ember.Route.extend
  model: -> Helplog.Post.createRecord()

Helplog.PostRoute = Ember.Route.extend Helplog.SetSession,
  model: (params) -> Helplog.Post.find params.post_id

Helplog.PostDeleteable = Ember.Mixin.create
  delete: (post) ->
    post.on 'didDelete', this, -> @transitionToRoute 'posts'
    post.deleteRecord()
    @get('store').commit()

Helplog.PostsController = Ember.ArrayController.extend Helplog.PostDeleteable

Helplog.PostController = Ember.ObjectController.extend Helplog.PostDeleteable

Helplog.PostsNewController = Ember.ObjectController.extend
  create: (post) ->
    post.on 'didCreate', this, -> @transitionToRoute 'post', post
    @get('store').commit()

Helplog.PostsEditController = Ember.ObjectController.extend
  save: (post) ->
    post.on 'didUpdate', this, -> @transitionToRoute 'post', post
    @get('store').commit()

Ember.Handlebars.registerBoundHelper 'markdown', (input) ->
  new Ember.Handlebars.SafeString window.markdown.toHTML(input) if input

Ember.Handlebars.registerBoundHelper 'truncatedMarkdown', (input) ->
  new Ember.Handlebars.SafeString window.markdown.toHTML(_.str.truncate(input, 300)) if input
