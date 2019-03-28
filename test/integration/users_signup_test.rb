require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  it 'should not create an invalid user' do
    assert_no_difference 'User.count' do
      post users_path, params: { user: { username: '',
                                         email: 'user@invalid',
                                         password: 'foo',
                                         password_confirmation: 'bar' } }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
  end

  it 'valid signup information' do
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { username: 'Noah Bogart',
                                         email: 'nbtheduke@gmail.com',
                                         password: 'password1234',
                                         password_confirmation: 'password1234' } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert flash[:success]
  end
end
