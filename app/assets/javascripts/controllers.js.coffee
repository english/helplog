Helplog.ApplicationController = Ember.Controller.extend
  isLoggedIn: (->
    @get('session.active')
  ).property('session.active')

Helplog.PostDeleteable = Ember.Mixin.create
  delete: (post) ->
    post.on 'didDelete', this, -> @transitionToRoute 'index'
    post.deleteRecord()
    @get('store').commit()

Helplog.PostsController = Ember.ArrayController.extend Helplog.PostDeleteable,
  needs: ['application']

Helplog.PostController = Ember.ObjectController.extend Helplog.PostDeleteable,
  needs: ['application']

Helplog.PostsNewController = Ember.ObjectController.extend
  create: (post) ->
    post.on 'didCreate', this, -> @transitionToRoute 'index'
    @get('store').commit()

Helplog.PostsEditController = Ember.ObjectController.extend
  save: (post) ->
    post.on 'didUpdate', this, -> @transitionToRoute 'index'
    @get('store').commit()

Helplog.SessionsNewController = Ember.ObjectController.extend
  needs: ['application']
  hasError: false
  login: ->
    $.post('/sessions', { session: @get('content').toJSON() }).then(
      =>
        @set 'hasError', false
        @set 'controllers.application.session.active', true
        @transitionToRoute 'index'
      => @set 'hasError', true
    )
