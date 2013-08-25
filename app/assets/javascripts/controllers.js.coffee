Helplog.ApplicationController = Ember.Controller.extend
  isLoggedInBinding: 'Helplog.isLoggedIn'
  showLoginForm: -> @set 'isLoggingIn', true

Helplog.LoginController = Ember.ObjectController.extend
  needs: 'application'
  cancel: -> @set 'controllers.application.isLoggingIn', false
  login: ->
    $.post('/sessions', { session: @get('content').toJSON() }).then(
      =>
        Helplog.set 'isLoggedIn', true
        @set 'hasError', false
        @set 'controllers.application.isLoggingIn', false
      => @set 'hasError', true
    )

Helplog.PostDeleteable = Ember.Mixin.create
  delete: (post) ->
    post.on 'didDelete', this, -> @transitionToRoute 'index'
    post.deleteRecord()
    @get('store').commit()

Helplog.PostsController = Ember.ArrayController.extend Helplog.PostDeleteable,
  isLoggedInBinding: 'Helplog.isLoggedIn'
  publishedPosts: (->
    @get('content').filterProperty('published', true)
  ).property 'content.@each.published'
  draftPosts: (->
    @get('content').filterProperty('published', false)
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
