truncatePostContent = ->
  _.each $('.truncate-post-content .post .content'), (content) ->
    truncated = _.str.truncate($(content).text(), 300)
    $(content).html("<p>#{truncated}</p>")

$(truncatePostContent)
document.addEventListener('page:change', truncatePostContent)

removeLinkFromPostTitle = ->
  titleText = $('.remove-link-from-post-title .title a').text()
  $('.remove-link-from-post-title .title').html(titleText)

$(removeLinkFromPostTitle)
document.addEventListener('page:change', removeLinkFromPostTitle)
