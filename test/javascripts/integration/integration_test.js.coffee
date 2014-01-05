module "Integration Tests",
  setup: ->
    App.reset()

login = ->
  click 'a:contains("Login")'
  fillIn 'input[name=Email]', 'someone@example.com'
  fillIn 'input[name=Password]', 'secret'
  click 'input[type=submit]'

logout = -> click 'a:contains("Logout")'

test "Login and save a post", ->
  visit '/'

  login()

  click 'a:contains("New Post")'
  fillIn 'input[name=Title]', 'Test Blog Post Title'
  fillIn 'textarea[name=Intro]', 'Test introduction.'
  fillIn 'textarea[name=Body]', 'Some test content.'
  click 'button:contains("Save")'

  andThen ->
    ok exists('.title:contains("Test Blog Post Title")'), 'Found post title'
    ok exists('.intro:contains("Test introduction.")'), 'Found post intro!'

    logout()

    andThen ->
      ok !exists('.title:contains("Test Blog Post Title")')
      ok !exists('.intro:contains("Test introduction.")')

      login()

      click '*:contains("Test Blog Post Title")'
      click '*:contains("Edit")'
      click 'input[name=Published]'
      click 'button:contains("Save")'

      andThen ->
        ok exists('.title:contains("Test Blog Post Title")')
        ok exists('.intro:contains("Test introduction.")')
