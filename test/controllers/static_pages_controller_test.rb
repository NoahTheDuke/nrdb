require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get static_pages_home_url
    assert_response :success
    assert_select "title", "Android: Netrunner Cards and Deckbuilder"
  end

  test "should get help" do
    get static_pages_help_url
    assert_response :success
    assert_select "title", "Help | NetrunnerDB"
  end

  test "should get cards" do
    get static_pages_cards_url
    assert_response :success
    assert_select "title", "Cards | NetrunnerDB"
  end

  test "should get root" do
    get root_url
    assert_response :success
  end

end
