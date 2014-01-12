module "Comments"

test "Create a comment", ->
  visit '/'
  clickLink 'Ember.js'

  clickLink 'New Comment'
  fillIn '.new-comment textarea[name=Author]', 'miserableGit'
  fillIn '.new-comment textarea[name=Body]', 'This is shit!'
  clickButton 'Save'

  andThen ->
    ok hasText 'This is shit!'
    ok hasText 'miserableGit'

test "Delete a comment", ->
  visit '/'
  login()

  clickLink 'Ember.js'
  click '.comments button:contains("Delete")'

  visit '/'
  clickLink 'Ember.js'

  andThen -> ok !hasText 'This is amaaazing!'
