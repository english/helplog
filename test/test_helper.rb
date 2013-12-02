ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'mocha/setup'

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL

  def setup(*)
    Capybara.current_driver = :poltergeist
    Capybara.reset!
    super
  end

  def login
    click_link 'Login'
    fill_in 'Email',    with: 'someone@example.com'
    fill_in 'Password', with: 'secret'
    click_button 'Log in'
  end
end
