Helplog.PostDeleteable = Ember.Mixin.create
  delete: (post) ->
    post.on 'didDelete', this, -> @transitionToRoute 'posts'
    post.deleteRecord()
    @get('store').commit()

Helplog.PostsController = Ember.ArrayController.extend Helplog.PostDeleteable,
  needs: ['application']

Helplog.PostController = Ember.ObjectController.extend Helplog.PostDeleteable,
  needs: ['application']

Helplog.PostsNewController = Ember.ObjectController.extend
  create: (post) ->
    post.on 'didCreate', this, -> @transitionToRoute 'post', post
    @get('store').commit()

Helplog.PostsEditController = Ember.ObjectController.extend
  save: (post) ->
    post.on 'didUpdate', this, -> @transitionToRoute 'post', post
    @get('store').commit()

Helplog.SessionsNewController = Ember.ObjectController.extend
  needs: ['application']
  login: ->
    $.post('/sessions',
      session:
        email: @get 'content.email'
        password: @get 'content.password'
    ).then =>
      @set 'controllers.application.session.active', true
      @transitionToRoute 'index'
