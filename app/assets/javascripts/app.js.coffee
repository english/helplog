window.App = Ember.Application.create()

Ember.Handlebars.registerBoundHelper 'markdown', (input) ->
  new Ember.Handlebars.SafeString window.markdown.toHTML(input) if input
