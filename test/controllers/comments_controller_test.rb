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
    get :index, format: :json

    regex = /\{"comments":\[\
{"id":\d+,"post_id":\d+,"body":"Ember.js is the shit\.","author":"ember_lover"\},\
{"id":\d+,"post_id":\d+,"body":"I love Rails 4\.","author":"rails_lover"\}\]\}/

    assert_match regex, @response.body
  end
end
