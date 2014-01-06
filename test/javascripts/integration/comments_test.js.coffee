module "Comments",
  setup: ->
    App.reset()
    App.Post.FIXTURES = App.Comment.FIXTURES = []
    Ember.run -> App.set 'isLoggedIn', false

test "Create a comment", ->
  App.Post.FIXTURES = [
    id: 1
    title: 'Ember.js'
    published: true
  ]

  visit '/'
  clickLink 'Ember.js'

  clickLink 'New Comment'
  fillIn '.new-comment textarea[name=Author]', 'jdog'
  fillIn '.new-comment textarea[name=Body]', 'This is amaaazing!'
  clickButton 'Save'

  andThen ->
    ok hasText 'This is amaaazing!'
    ok hasText 'jdog'

test "Delete a comment", ->
  App.Post.FIXTURES = [
    id: 1
    title: 'Ember.js'
    published: true
    comments: [1]
  ]

  App.Comment.FIXTURES = [
    id: 1
    post: 1
    author: 'jdog'
    body: 'This is amaaazing!'
  ]

  visit '/'
  login()

  clickLink 'Ember.js'
  click '.comments button:contains("Delete")'

  visit '/'
  clickLink 'Ember.js'

  andThen -> ok !hasText 'This is amaaazing!'
