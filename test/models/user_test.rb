require 'test_helper'

class UserTest < ActiveSupport::TestCase
  it 'should be valid' do
    user = User.new(name: 'Example User', email: 'user@example.com')
    assert user.valid?
  end
end
