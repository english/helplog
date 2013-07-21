require 'test_helper'

class ManagePostTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  test "Added posts appear on the home page once published" do
    visit login_path
    fill_in 'Email', with: 'someone@example.com'
    fill_in 'Password', with: 'secret'
    click_button 'Log in'

    visit new_post_path
    fill_in 'Title', with: 'Test Blog Post Title'
    fill_in 'Content', with: 'Some test content.'
    click_button 'Create Post'

    visit posts_path
    assert page.has_content?('Test Blog Post Title')
    assert page.has_content?('Some test content.')

    visit published_posts_path
    refute page.has_content?('Test Blog Post Title')
    refute page.has_content?('Some test content.')

    visit unpublished_posts_path
    assert page.has_content?('Test Blog Post Title')
    assert page.has_content?('Some test content.')

    visit edit_post_path(Post.last)
    check 'Published'
    click_button 'Update Post'

    visit published_posts_path
    assert page.has_content?('Test Blog Post Title')
    assert page.has_content?('Some test content.')
  end
end
