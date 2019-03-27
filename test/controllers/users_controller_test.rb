require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  it 'should get new' do
    get signup_path
    assert_response :success
  end
end
