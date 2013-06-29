require 'test_helper'

class AddPostTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  test "Added posts appear on the home page" do
    visit '/login'
    fill_in 'Email', with: 'someone@example.com'
    fill_in 'Password', with: 'secret'
    click_button 'Log in'

    visit '/posts/new'
    fill_in 'Title', with: 'Test Blog Post Title'
    fill_in 'Content', with: 'Some test content.'
    click_button 'Create Post'


    visit '/'
    assert page.has_content?('Test Blog Post Title')
    assert page.has_content?('Some test content.')
  end
end
