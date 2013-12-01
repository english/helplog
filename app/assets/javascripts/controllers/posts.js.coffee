App.PostDeleteable = Ember.Mixin.create
  actions:
    delete: (post) ->
      post = @get 'model'
      post.on 'didDelete', this, -> @transitionToRoute 'index'
      post.deleteRecord()
      post.save()

App.PostsController = Ember.ArrayController.extend
  isLoggedInBinding: 'App.isLoggedIn'
  publishedPosts: (->
    @get('content').filterProperty('published', true).sort (x, y) ->
      x.get('updatedAt') < y.get('updatedAt')
  ).property 'content.@each.published'
  draftPosts: (->
    @get('content').filterProperty('published', false).sort (x, y) ->
      x.get('updatedAt') < y.get('updatedAt')
  ).property 'content.@each.published'
  hasDraftPosts: (->
    @get('draftPosts').length > 0
  ).property 'content.@each.published'

App.PostController = Ember.ObjectController.extend App.PostDeleteable,
  isLoggedIn: null
  isLoggedInBinding: 'App.isLoggedIn'

App.PostsPreviewController = Ember.ObjectController.extend App.PostDeleteable,
  isLoggedIn: null
  isLoggedInBinding: 'App.isLoggedIn'

App.PostsNewController = Ember.ObjectController.extend
  postAction: 'New'
  actions:
    save: ->
      post = @get 'model'
      post.on 'didCreate', this, -> @transitionToRoute 'index'
      post.save()

App.PostsEditController = Ember.ObjectController.extend
  postAction: 'Edit'
  actions:
    save: ->
      post = @get 'model'
      post.on 'didUpdate', this, -> @transitionToRoute 'index'
      post.save()
