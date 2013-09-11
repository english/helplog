window.App = Ember.Application.create()

Ember.Handlebars.registerBoundHelper 'markdown', (input) ->
  new Ember.Handlebars.SafeString window.markdown.toHTML(input) if input

Ember.Handlebars.helper 'format-date', (date) ->
  moment(date).format('MMMM Do YYYY')
