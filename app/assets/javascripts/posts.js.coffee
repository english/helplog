truncatePostContent = ->
  content = $('.truncate-post-content .post .content').text()
  truncatedContent = _.str.truncate(content, 200)
  $('.truncate-post-content .post .content').html("<p>#{truncatedContent}</p>")

$(truncatePostContent)
document.addEventListener 'page:change', truncatePostContent
