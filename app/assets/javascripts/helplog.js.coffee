window.Helplog = Ember.Application.create LOG_TRANSITIONS: true

Ember.Handlebars.registerBoundHelper 'markdown', (input) ->
  new Ember.Handlebars.SafeString window.markdown.toHTML(input) if input

Ember.Handlebars.registerBoundHelper 'truncatedMarkdown', (input) ->
  new Ember.Handlebars.SafeString window.markdown.toHTML(_.str.truncate(input, 300)) if input
