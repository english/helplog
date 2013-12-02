App.CommentController = Ember.ObjectController.extend
  needs: ['post']
  isLoggedIn: null
  isLoggedInBinding: 'App.isLoggedIn'
  actions:
    deleteComment: (comment) ->
      comment.deleteRecord()
      comment.save().then =>
        @get('controllers.post.content.comments').removeObject comment

App.PostNewCommentController = Ember.ObjectController.extend
  needs: ['post']
  actions:
    save: (comment) ->
      comment.save().then =>
        @get('controllers.post.content.comments').addObject comment
        @transitionToRoute 'post', @get('controllers.post.content')
      , => @set 'hasError', true
