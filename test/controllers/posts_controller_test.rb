require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  setup do
    @post = posts(:one)
  end

  test "should get index when logged in" do
    session[:current_user] = users(:test_user).id
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should not get index when logged out" do
    session[:current_user] = nil
    get :index
    assert_redirected_to login_path
  end

  test "should get new when logged in" do
    session[:current_user] = users(:test_user).id
    get :new
    assert_response :success
  end

  test "should not get new when logged out" do
    session[:current_user] = nil
    get :new
    assert_redirected_to login_path
  end

  test "should create post" do
    assert_difference('Post.count') do
      post :create, post: { content: @post.content, title: @post.title, published: @post.published }
    end

    assert_redirected_to post_path(assigns(:post))
  end

  test "should show post" do
    get :show, id: @post
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @post
    assert_response :success
  end

  test "should update post" do
    patch :update, id: @post, post: { content: @post.content, title: @post.title, published: @post.published }
    assert_redirected_to post_path(assigns(:post))
  end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete :destroy, id: @post
    end

    assert_redirected_to posts_path
  end
end
