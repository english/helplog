App.CommentController = Ember.ObjectController.extend
  isLoggedIn: null
  isLoggedInBinding: 'App.isLoggedIn'
  actions:
    deleteComment: (comment) ->
      comment.deleteRecord()
      comment.save()
