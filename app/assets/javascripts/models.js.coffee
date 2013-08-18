Helplog.Store = DS.Store.extend
  revision: 13
  adapter: DS.RESTAdapter.create()

Helplog.Session = DS.Model.extend
  active: DS.attr('boolean')
  email: DS.attr('string')
  password: DS.attr('string')

Helplog.Post = DS.Model.extend
  title: DS.attr('string')
  intro: DS.attr('string')
  body: DS.attr('string')
  published: DS.attr('boolean')
