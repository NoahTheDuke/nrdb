require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test 'full title helper' do
    assert_equal full_title, 'Android: Netrunner Cards and Deckbuilder'
    assert_equal full_title('Help'), 'Help | NetrunnerDB'
  end
end
