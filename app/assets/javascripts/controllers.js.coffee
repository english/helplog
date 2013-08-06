Helplog.ApplicationController = Ember.Controller.extend
  logout: ->
    @get('session').on 'didDelete', ->
      @get('session').set('active', false)
      @transitionToRoute 'posts'

    @get('session').deleteRecord()
    @get('store').commit()
  sessionActive: (->
    @get('session.active')
  ).property('session.active')

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

Helplog.SessionsNewController = Ember.ObjectController.extend
  login: (session) ->
    session.on 'didCreate', this, -> @transitionToRoute 'posts'
    @get('store').commit()
