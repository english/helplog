toggleLoggedInElements = ->
  $.getJSON '/session/active', (json) ->
    if json.session.active
      $('.show-when-logged-in').show()
      $('.hide-when-logged-in').hide()

document.addEventListener 'page:change', toggleLoggedInElements
$(toggleLoggedInElements)
