require 'test_helper'

class ManageCommentsTest < ActionDispatch::IntegrationTest
  test "adding a comment" do
    visit root_path

    click_link 'tmux'
    click_link 'New Comment'

    within '.new-comment' do
      fill_in 'body', with: 'This is amaaazing!'
      click_button 'Save'
    end
    
    sleep 0.25

    visit root_path
    click_link 'tmux'

    assert page.has_content?('This is amaaazing!')
  end

  test "deleting a comment" do
    visit root_path
    login
    sleep 0.25

    click_link 'Ember.js'
    assert page.has_content?('Ember.js is the shit.')

    within '.comments' do
      click_button 'Delete'
    end

    click_link 'Logout'

    visit root_path
    click_link 'Ember.js'

    refute page.has_content?('Ember.js is the shit.')
  end
end
