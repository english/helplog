#= require application
#= require jquery.mockjax
#= require_self
#= require_tree .

@ENV = env: 'test'

document.write """
               <div id="ember-testing-container">
                 <div id="ember-testing"></div>
               </div>
               """

document.write """
               <style>
                 #ember-testing-container {
                   position: absolute;
                   background: white;
                   bottom: 0;
                   right: 0;
                   width: 640px;
                   height: 384px;
                   overflow: auto;
                   z-index: 9999;
                   border: 1px solid #ccc;
                 }

                 #ember-testing {
                   zoom: 50%;
                 }
               </style>
               """

setFixtures = ->
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

App.rootElement = '#ember-testing'
App.setupForTesting()
App.injectTestHelpers()
setFixtures()

App.Store = DS.Store.extend
  adapter: DS.FixtureAdapter.extend simulateRemoteResponse: false

QUnit.testStart ->
  App.reset()
  setFixtures()
  Ember.run -> App.set 'isLoggedIn', false

@login = ->
  click 'a:contains("Login")'
  fillIn 'input[name=Email]', 'someone@example.com'
  fillIn 'input[name=Password]', 'secret'
  click 'input[type=submit]'

@logout = -> click 'a:contains("Logout")'
@exists = (selector) -> !!find(selector).length

@clickLink = (text) -> click "a:contains('#{text}')"
@clickButton = (text) -> click "button:contains('#{text}')"

@hasText = (text) -> hasTextWithin text, '*'
@hasTextWithin = (text, selector) -> exists "#{selector}:contains('#{text}')"

Ember.$.mockjax
  url: '/sessions/current'
  dataType: 'json'

Ember.$.mockjax
  url: '/sessions'
  dataType: 'json'

Ember.$.mockjaxSettings.logging = false;
Ember.$.mockjaxSettings.responseTime = 0;
