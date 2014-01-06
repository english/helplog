module "Posts",
  setup: ->
    App.reset()
    App.Post.FIXTURES = App.Comment.FIXTURES = []
    Ember.run -> App.set 'isLoggedIn', false

test "Create a post", ->
  visit '/'

  login()

  clickLink 'New Post'
  fillIn 'input[name=Title]', 'Test Blog Post Title'
  fillIn 'textarea[name=Intro]', 'Test introduction.'
  fillIn 'textarea[name=Body]', 'Some test content.'
  clickButton 'Save'

  andThen ->
    ok hasTextWithin 'Test Blog Post Title', '.title'
    ok hasTextWithin 'Test introduction.', '.intro'

  logout()

  andThen ->
    ok !hasTextWithin 'Test Blog Post Title', '.title'
    ok !hasTextWithin 'Test introduction.', '.intro'

  login()

  clickLink 'Test Blog Post Title'
  clickLink 'Edit'
  click 'input[name=Published]'
  clickButton 'Save'

  andThen ->
    ok hasTextWithin 'Test Blog Post Title', '.title'
    ok hasTextWithin 'Test introduction.', '.intro'
