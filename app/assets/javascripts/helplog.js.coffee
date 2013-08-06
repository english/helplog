window.Helplog = Ember.Application.create();

Helplog.Store = DS.Store.extend
  revision: 13
  adapter: DS.RESTAdapter.create()

Helplog.Session = DS.Model.extend
  active: DS.attr('boolean')

Helplog.Post = DS.Model.extend
  title: DS.attr('string')
  body: DS.attr('string')
  published: DS.attr('boolean')

Helplog.Router.map ->
  @resource 'posts'
  @route 'posts.new', path: '/posts/new'
  @resource 'post', path: '/posts/:post_id'
  @route 'posts.edit', path: '/posts/:post_id/edit'

Helplog.IndexRoute = Ember.Route.extend
  redirect: -> @transitionTo 'posts'

Helplog.PostsRoute = Ember.Route.extend
  model: -> Helplog.Post.find()

Helplog.PostsNewRoute = Ember.Route.extend
  model: -> Helplog.Post.createRecord()

Helplog.PostRoute = Ember.Route.extend
  model: (params) -> Helplog.Post.find params.post_id

Helplog.PostsController = Ember.ObjectController.extend
  delete: (post) ->
    post.on 'didDelete', this, ->
      @transitionToRoute 'posts'
    post.deleteRecord()
    @get('store').commit()

Helplog.PostController = Ember.ObjectController.extend
  delete: (post) ->
    post.on 'didDelete', this, ->
      @transitionToRoute 'posts'
    post.deleteRecord()
    @get('store').commit()

Helplog.PostsNewController = Ember.ObjectController.extend
  create: (post) ->
    post.on 'didCreate', this, ->
      @transitionToRoute 'post', post
    @get('store').commit()

Helplog.PostsEditController = Ember.ObjectController.extend
  save: (post) ->
    post.on 'didUpdate', this, ->
      @transitionToRoute 'post', post
    @get('store').commit()

Ember.Handlebars.registerBoundHelper 'markdown', (input) ->
  if input
    new Ember.Handlebars.SafeString window.markdown.toHTML(input)

Ember.Handlebars.registerBoundHelper 'truncatedMarkdown', (input) ->
  if input
    truncated = _.str.truncate(input, 300)
    new Ember.Handlebars.SafeString window.markdown.toHTML(truncated)
