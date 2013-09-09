App.ApplicationController = Ember.Controller.extend
  isLoggedInBinding: 'App.isLoggedIn'
  actions:
    showLoginForm: -> @set 'isLoggingIn', true
    logout: ->
      App.Session.create().destroy().then -> App.set 'isLoggedIn', false

App.LoginController = Ember.ObjectController.extend
  needs: 'application'
  actions:
    cancel: -> @set 'controllers.application.isLoggingIn', false
    login: ->
      saving = @get('content').save()
      saving.done =>
        App.set 'isLoggedIn', true
        @set 'hasError', false
        @set 'controllers.application.isLoggingIn', false
      saving.fail => @set 'hasError', true

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
    @get('content').filterProperty('published', true)
  ).property 'content.@each.published'
  draftPosts: (->
    @get('content').filterProperty('published', false)
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
