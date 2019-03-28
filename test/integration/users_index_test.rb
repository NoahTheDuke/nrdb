require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  it 'index including pagination' do
    user = create(:user)
    log_in_as(user)
    50.times do |i|
      create(:user, username: "User #{i}", email: "e#{i}@example.com")
    end
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    User.paginate(page: 1).each do |u|
      assert_select 'a[href=?]', user_path(u), text: u.username
    end
  end
end
