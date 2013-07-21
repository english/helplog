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

  test "should get index when logged in" do
    login

    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should not get index when logged out" do
    logout

    get :index
    assert_redirected_to login_path
  end

  test "should not get unpublished when logged out" do
    logout

    get :index
    assert_redirected_to login_path
  end

  test "should get published posts when logged out" do
    logout

    get :published
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should get new when logged in" do
    login

    get :new
    assert_response :success
  end

  test "should not get new when logged out" do
    logout

    get :new
    assert_redirected_to login_path
  end

  test "should create post" do
    login

    assert_difference('Post.count') do
      post :create, post: { content: @post.content, title: @post.title, published: @post.published }
    end

    assert_redirected_to post_path(assigns(:post))
  end

  test "should not create post when logged out" do
    logout

    assert_no_difference('Post.count') do
      post :create, post: { content: @post.content, title: @post.title, published: @post.published }
    end

    assert_redirected_to login_path
  end

  test "should not show unpublished post when logged out" do
    logout

    get :show, id: @post
    assert_response :forbidden
  end

  test "should show published post when logged out" do
    logout

    get :show, id: posts(:tmux)
    assert_response :success
  end

  test "should show unpublished post when logged in" do
    login

    get :show, id: @post
    assert_response :success
  end

  test "should get edit when logged in" do
    login

    get :edit, id: @post
    assert_response :success
  end

  test "should not get edit when logged out" do
    logout

    get :edit, id: @post
    assert_redirected_to login_path
  end

  test "should update post when logged in" do
    login

    patch :update, id: @post, post: { content: @post.content, title: @post.title, published: @post.published }
    assert_redirected_to post_path(assigns(:post))
  end

  test "should not update post when logged out" do
    logout

    patch :update, id: @post, post: { content: @post.content, title: @post.title, published: @post.published }
    assert_redirected_to login_path
  end

  test "should destroy post when logged in" do
    login

    assert_difference('Post.count', -1) do
      delete :destroy, id: @post
    end

    assert_redirected_to posts_path
  end

  test "should not destroy post when logged logged out" do
    logout

    assert_no_difference('Post.count') do
      delete :destroy, id: @post
    end

    assert_redirected_to login_path
  end
end
