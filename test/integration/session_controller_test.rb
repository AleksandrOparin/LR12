require 'test_helper'

class SessionControllerTest < ActionDispatch::IntegrationTest
  fixtures :users

  test 'unauthorized user will be redirected to login page' do
    get root_url
    assert_redirected_to controller: :session, action: :login
  end

  test 'user with incorrect credentials will be redirected to login page' do
    post session_create_url, params: { login: Faker::Internet.username, password: Faker::Internet.password(min_length: 8) }
    assert_redirected_to controller: :session, action: :login
  end

  test 'user with correct credentials will see the root' do
    password = Faker::Internet.password(min_length: 8)

    user = User.create(username: Faker::Internet.username, email: Faker::Internet.email, password: password, password_confirmation: password)

    post session_create_url, params: { login: user.username, password: password }

    assert_redirected_to controller: :palindrome, action: :input
  end

  test 'user will see the root after signing up' do
    username = Faker::Internet.username
    email = Faker::Internet.email
    password = Faker::Internet.password(min_length: 8)

    post users_url, params: { user: { username: username, email: email, password: password, password_confirmation: password } }

    assert_redirected_to root_url
  end

  test 'user can logout' do
    password = Faker::Internet.password(min_length: 8)

    user = User.create(username: Faker::Internet.username, email: Faker::Internet.email, password: password, password_confirmation: password)

    post session_create_url, params: { login: user.username, password: password }

    get session_logout_url

    assert_redirected_to controller: :session, action: :login
  end
end