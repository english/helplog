App.ApplicationSerializer = DS.RESTSerializer.extend
  normalize: (type, hash, property) ->
    normalized = {}
    for prop of hash
      normalizedProp = if prop.substr(-3) is "_id" # belongsTo relationships
        prop.slice(0, -3)
      else if prop.substr(-4) is "_ids" # hasMany relationship
        Ember.String.pluralize(prop.slice(0, -4))
      else # regualarAttribute
        prop
      normalized[Ember.String.camelize(normalizedProp)] = hash[prop]
    @_super type, normalized, property

