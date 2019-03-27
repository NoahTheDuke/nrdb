require 'test_helper'

class UserTest < ActiveSupport::TestCase
  describe 'A user' do
    it 'should be valid' do
      user = build(:user)
      assert user.valid?
    end

    it 'with no username should be invalid' do
      user = build(:user, username: '')
      assert_not user.valid?
    end

    it 'with no email should be invalid' do
      user = build(:user, email: '')
      assert_not user.valid?
    end
  end
end
