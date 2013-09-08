Helplog.ApplicationController = Ember.Controller.extend
  isLoggedInBinding: 'Helplog.isLoggedIn'
  actions:
    showLoginForm: -> @set 'isLoggingIn', true
    logout: ->
      Helplog.Session.create().destroy().then -> Helplog.set 'isLoggedIn', false

Helplog.LoginController = Ember.ObjectController.extend
  needs: 'application'
  actions:
    cancel: -> @set 'controllers.application.isLoggingIn', false
    login: ->
      saving = @get('content').save()
      saving.done =>
        Helplog.set 'isLoggedIn', true
        @set 'hasError', false
        @set 'controllers.application.isLoggingIn', false
      saving.fail => @set 'hasError', true

Helplog.PostDeleteable = Ember.Mixin.create
  actions:
    delete: (post) ->
      post = @get 'model'
      post.on 'didDelete', this, -> @transitionToRoute 'index'
      post.deleteRecord()
      post.save()

Helplog.PostsController = Ember.ArrayController.extend
  isLoggedInBinding: 'Helplog.isLoggedIn'
  publishedPosts: (->
    @get('content').filterProperty('published', true)
  ).property 'content.@each.published'
  draftPosts: (->
    @get('content').filterProperty('published', false)
  ).property 'content.@each.published'
  hasDraftPosts: (->
    @get('draftPosts').length > 0
  ).property 'content.@each.published'

Helplog.PostController = Ember.ObjectController.extend Helplog.PostDeleteable,
  isLoggedIn: null
  isLoggedInBinding: 'Helplog.isLoggedIn'

Helplog.PostsPreviewController = Ember.ObjectController.extend Helplog.PostDeleteable,
  isLoggedIn: null
  isLoggedInBinding: 'Helplog.isLoggedIn'

Helplog.PostsNewController = Ember.ObjectController.extend
  postAction: 'New'
  actions:
    save: ->
      post = @get 'model'
      post.on 'didCreate', this, -> @transitionToRoute 'index'
      post.save()

Helplog.PostsEditController = Ember.ObjectController.extend
  postAction: 'Edit'
  actions:
    save: ->
      post = @get 'model'
      post.on 'didUpdate', this, -> @transitionToRoute 'index'
      post.save()
