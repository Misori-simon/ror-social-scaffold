require 'rails_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  User.create(email: 'test_user@gmail.com', name: 'test_user', password: 'password')

  test 'visit  ' do
    Capybara.visit('new_user_session_path')
    Capybara.fill_in 'email', with: 'test_user@gmail.com'
    Capybara.fill_in 'paswword', with: 'password'
    old_path = Capybara.page.current_path
    Capybara.page.first("input[type='submit']").click
    sleep 0.1
    new_path = Capybara.page.current_path
    assert_not_equal(old_path, new_path)
  end
end
