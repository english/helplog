toggleLoggedInElements = ->
  $.getJSON '/session/active', (json) ->
    if json.session.active
      $('.show-when-logged-in').removeClass('hidden')
      $('.hide-when-logged-in').addClass('hidden')

document.addEventListener 'page:change', toggleLoggedInElements
$(toggleLoggedInElements)
