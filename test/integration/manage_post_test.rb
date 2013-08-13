require 'test_helper'

class ManagePostTest < ActionDispatch::IntegrationTest
  include Capybara::DSL
  Capybara.current_driver = :poltergeist

  test "Added posts appear on the home page once published" do
    visit '/'
    click_link 'Login'

    fill_in 'Email', with: 'someone@example.com'
    fill_in 'Password', with: 'secret'
    click_button 'Log in'

    click_link 'New Post'
    fill_in 'Title', with: 'Test Blog Post Title'
    fill_in 'Body', with: 'Some test content.'
    click_button 'Save'

    assert page.has_content?('Test Blog Post Title')
    assert page.has_content?('Some test content.')
  end
end
