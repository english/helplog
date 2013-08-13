require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "logging in with valid credentials" do
    post :create, { session: valid_credentials, format: :json }
    assert_response :success
    assert_equal users(:test_user).id, session[:current_user]
  end

  test "logging in with invalid credentials" do
    post :create, { session: invalid_credentials, format: :json }
    assert_response :unprocessable_entity
  end

  test "logging out" do
    session[:current_user] = 1
    delete :destroy, id: 'current', format: :json
    assert_nil session[:current_user]
  end

  private

  def valid_credentials
    { email: 'someone@example.com', password: 'secret' }
  end

  def invalid_credentials
    { email: 'someone@example.com', password: 'password' }
  end
end
