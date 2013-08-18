Helplog.ApplicationController = Ember.Controller.extend
  isLoggedInBinding: 'Helplog.isLoggedIn'

Helplog.PostDeleteable = Ember.Mixin.create
  delete: (post) ->
    post.on 'didDelete', this, -> @transitionToRoute 'index'
    post.deleteRecord()
    @get('store').commit()

Helplog.PostsController = Ember.ArrayController.extend Helplog.PostDeleteable,
  isLoggedInBinding: 'Helplog.isLoggedIn'
  posts: (->
    if @get('isLoggedIn') then @get('content') else @get('publishedPosts')
  ).property 'isLoggedIn', 'content', 'publishedPosts'
  publishedPosts: (->
    @get('content').filterProperty('published', true)
  ).property 'content.@each.published'

Helplog.PostController = Ember.ObjectController.extend Helplog.PostDeleteable,
  isLoggedIn: null
  isLoggedInBinding: 'Helplog.isLoggedIn'

Helplog.PostsNewController = Ember.ObjectController.extend
  create: (post) ->
    post.on 'didCreate', this, -> @transitionToRoute 'index'
    @get('store').commit()

Helplog.PostsEditController = Ember.ObjectController.extend
  save: (post) ->
    post.on 'didUpdate', this, -> @transitionToRoute 'index'
    @get('store').commit()

Helplog.SessionsNewController = Ember.ObjectController.extend
  hasError: false
  login: ->
    $.post('/sessions', { session: @get('content').toJSON() }).then(
      =>
        Helplog.set 'isLoggedIn', true
        @set 'hasError', false
        @transitionToRoute 'index'
      => @set 'hasError', true
    )
