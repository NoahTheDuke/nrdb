require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get static_pages_home_url
    assert_response :success
    assert_select "title", "NetrunnerDB | Android: Netrunner Cards and Deckbuilder"
  end

  test "should get help" do
    get static_pages_help_url
    assert_response :success
    assert_select "title", "NetrunnerDB | Help"
  end

  test "should get cards" do
    get static_pages_cards_url
    assert_response :success
    assert_select "title", "NetrunnerDB | Cards"
  end

  test "should get root" do
    get root_url
    assert_response :success
  end

end
