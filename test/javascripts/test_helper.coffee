#= require application
#= require_tree .
#= require_self

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

App.rootElement = '#ember-testing'
App.setupForTesting()
App.injectTestHelpers()

App.Store = DS.Store.extend
  adapter: DS.FixtureAdapter

App.Post.FIXTURES = []
App.Comment.FIXTURES = []

window.login = ->
  click 'a:contains("Login")'
  fillIn 'input[name=Email]', 'someone@example.com'
  fillIn 'input[name=Password]', 'secret'
  click 'input[type=submit]'

window.logout = -> click 'a:contains("Logout")'
window.exists = (selector) -> !!find(selector).length

window.clickLink = (text) -> click "a:contains('#{text}')"
window.clickButton = (text) -> click "button:contains('#{text}')"

window.hasText = (text) -> hasTextWithin text, '*'
window.hasTextWithin = (text, selector) -> exists "#{selector}:contains('#{text}')"
