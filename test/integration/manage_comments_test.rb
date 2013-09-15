require 'test_helper'

class ManageCommentsTest < ActionDispatch::IntegrationTest
  include Capybara::DSL
  Capybara.current_driver = :poltergeist

  test "adding a comment" do
    visit root_path

    click_link 'tmux'
    click_link 'New Comment'

    fill_in 'Comment', with: 'This is amaaazing!'
    click_button 'Save'
    
    sleep 0.5

    visit root_path
    click_link 'tmux'

    assert page.has_content('This is amaaazing!')
  end
end
