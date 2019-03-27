require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test 'should get root' do
    get root_path
    assert_response :success
    assert_select 'title', 'Android: Netrunner Cards and Deckbuilder'
  end

  test 'should get help' do
    get help_path
    assert_response :success
    assert_select 'title', 'Help | NetrunnerDB'
  end

  test 'should get cards' do
    get cards_path
    assert_response :success
    assert_select 'title', 'Cards | NetrunnerDB'
  end

  test 'should get contact' do
    get contact_path
    assert_response :success
    assert_select 'title', 'Contact | NetrunnerDB'
  end
end
