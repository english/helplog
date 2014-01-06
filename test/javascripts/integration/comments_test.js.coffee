module "Comments",
  setup: ->
    Ember.run ->
      App.Post.FIXTURES = [
        {
          id: 1
          title: 'Ember.js'
          published: true
          intro: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer lacinia aliquam mauris a mattis.'
          body: """
                Fusce accumsan vitae nibh nec pretium. Etiam a vestibulum purus, non feugiat ipsum. Vestibulum imperdiet risus neque, vitae auctor risus volutpat lacinia. Nunc sagittis mauris eu malesuada varius. Maecenas mi dui, tempus sit amet tempor et, cursus a turpis. Aliquam posuere neque in diam aliquet venenatis. Donec eu rutrum lectus, commodo tempus dui.
                Mauris elementum consequat rhoncus. Vestibulum tristique, nibh vitae lacinia interdum, nulla dui venenatis dolor, vitae pretium felis tellus eu mi. Praesent magna urna, accumsan sed libero at, sagittis fringilla nunc. Cras vehicula est eros, ac pharetra elit volutpat at. Etiam venenatis rhoncus nisl, a venenatis risus. Vivamus porttitor rutrum leo sit amet fermentum. Interdum et malesuada fames ac ante ipsum primis in faucibus. Praesent vel mattis nisi. Sed a placerat est. Curabitur fringilla, nisl sit amet pellentesque venenatis, magna risus varius lorem, sed suscipit enim justo eget ante. Nam ac fringilla mi, id commodo magna. Nulla nec urna eget augue sollicitudin dictum eu eget ante. Mauris ligula diam, lobortis vitae purus sed, bibendum scelerisque augue. Vestibulum et nibh non enim ultricies viverra. Quisque scelerisque, tortor eget sollicitudin cursus, nisi arcu rutrum risus, a fermentum mi quam vitae lectus. Vivamus pretium lacus eget auctor dapibus.
                """
          comments: [1]
        }
      ]

      App.Comment.FIXTURES = [
        {
          id: 1
          post: 1
          body: 'Ember.js is the shit.'
          author: 'ember_lover'
        }
      ]

      App.set 'isLoggedIn', false
      App.reset()

login = ->
  click 'a:contains("Login")'
  fillIn 'input[name=Email]', 'someone@example.com'
  fillIn 'input[name=Password]', 'secret'
  click 'input[type=submit]'

logout = -> click 'a:contains("Logout")'

test "Deleting a comment", ->
  visit '/'
  login()
  click 'a:contains("Ember.js")'

  andThen ->
    ok exists('*:contains("Ember.js is the shit.")')

    click '.comments button:contains("Delete")'
    visit '/'
    click 'a:contains("Ember.js")'

    andThen ->
      ok !exists('*:contains("Ember.js is the shit.")')
