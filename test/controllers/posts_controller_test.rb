require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  setup do
    @post = posts(:rails_4)
  end

  def login
    session[:current_user] = users(:test_user).id
  end

  def logout
    session[:current_user] = nil
  end

  test "should create post" do
    login

    assert_difference('Post.count') do
      post :create, post: { body: @post.body, title: @post.title, published: @post.published }, format: :json
    end

    assert_response :success
  end

  test "should not create post when logged out" do
    logout

    assert_no_difference('Post.count') do
      post :create, post: { body: @post.body, title: @post.title, published: @post.published }, format: :json
    end

    assert_response :forbidden
  end

  test "should update post when logged in" do
    login

    patch :update, id: @post, post: { body: @post.body, title: @post.title, published: @post.published }, format: :json
    assert_response :success
  end

  test "should not update post when logged out" do
    logout

    patch :update, id: @post, post: { body: @post.body, title: @post.title, published: @post.published }, format: :json
    assert_response :forbidden
  end

  test "should destroy post when logged in" do
    login

    assert_difference('Post.count', -1) do
      delete :destroy, id: @post, format: :json
    end

    assert_response :success
  end

  test "should not destroy post when logged logged out" do
    logout

    assert_no_difference('Post.count') do
      delete :destroy, id: @post, format: :json
    end

    assert_response :forbidden
  end
end
