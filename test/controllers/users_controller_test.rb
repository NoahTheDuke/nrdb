require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  it 'should redirect index when not logged in' do
    get users_path
    assert_redirected_to login_url
  end

  it 'should redirect edit when not logged in' do
    user = create(:user)
    get edit_user_path(user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  it 'should redirect update when not logged in' do
    user = create(:user)
    patch user_path(user), params: { user: { username: user.username,
                                             email: user.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  it 'should redirect edit when logged in as wrong user' do
    user = create(:user)
    other_user = create(:user, username: 'temp',
                               email: 'temp@temp.com',
                               password: 'password1234',
                               password_confirmation: 'password1234')
    log_in_as(other_user)
    get edit_user_path(user)
    assert flash.empty?
    assert_redirected_to root_url
  end

  it 'should redirect update when logged in as wrong user' do
    user = create(:user)
    other_user = create(:user, username: 'temp',
                               email: 'temp@temp.com',
                               password: 'password1234',
                               password_confirmation: 'password1234')
    log_in_as(other_user)
    patch user_path(user), params: { user: { username: user.username,
                                             email: user.email } }
    assert flash.empty?
    assert_redirected_to root_url
  end
end
