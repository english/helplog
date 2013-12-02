require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  test "create" do
    params = { author: 'Dave', body: 'good stuff', post_id: posts(:rails_4).id }

    assert_difference 'Comment.count', 1 do
      post :create, comment: params, format: :json
    end

    assert_response :success
    assert_equal 'Dave', Comment.last.author
    assert_equal 'good stuff', Comment.last.body
    assert_equal posts(:rails_4), Comment.last.post
  end

  test "index" do
    comment_doubles = [
      OpenStruct.new(id: 1, post_id: 1, body: 'Shits dope', author: 'Some dude'),
      OpenStruct.new(id: 2, post_id: 1, body: 'Its crap', author: 'MiserableGit')
    ]

    Comment.expects(:all)
           .returns(comment_doubles)

    get :index, format: :json

    assert_equal '{"comments":[{"table":{"id":1,"post_id":1,"body":"Shits dope","author":"Some dude"}},{"table":{"id":2,"post_id":1,"body":"Its crap","author":"MiserableGit"}}]}', @response.body
  end
end
