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
    fill_in 'Intro', with: 'Test introduction.'
    fill_in 'Body', with: 'Some test content.'
    click_button 'Save'

    click_link 'Logout'

    sleep 0.25

    refute page.has_content?('Test Blog Post Title')
    refute page.has_content?('Test introduction.')

    click_link 'Login'

    fill_in 'Email', with: 'someone@example.com'
    fill_in 'Password', with: 'secret'
    click_button 'Log in'

    sleep 0.25

    click_link 'Test Blog Post Title'
    click_link 'Edit'
    check 'Published?'
    click_button 'Save'

    click_link 'Logout'

    sleep 0.25

    assert page.has_content?('Test Blog Post Title')
    assert page.has_content?('Test introduction.')
  end
end
