class SessionsControllerTest < ActionController::TestCase
  test "logging in with valid credentials" do
    post :create, valid_credentials
    assert_redirected_to root_path
    assert_equal users(:test_user).id, session[:current_user]
  end

  test "logging in with invalid credentials" do
    post :create, invalid_credentials
    assert_template 'sessions/new'
    assert_nil session[:current_user]
  end

  test "get on new when already logged in redirects to home page" do
    session[:current_user] = 1
    get :new
    assert_redirected_to root_path
  end

  test "post to create when already logged in redirects to home page" do
    session[:current_user] = 1
    post :create, valid_credentials
    assert_redirected_to root_path
    assert_equal 1, session[:current_user]
  end

  test "logging out" do
    session[:current_user] = 1
    delete :destroy
    assert_nil session[:current_user]
    assert_redirected_to root_path
  end

  private

  def valid_credentials
    { email: 'someone@example.com', password: 'secret' }
  end

  def invalid_credentials
    { email: 'someone@example.com', password: 'password' }
  end
end
