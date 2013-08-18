window.Helplog = Ember.Application.create
  LOG_TRANSITIONS: true

Ember.Handlebars.registerBoundHelper 'markdown', (input) ->
  new Ember.Handlebars.SafeString window.markdown.toHTML(input) if input
