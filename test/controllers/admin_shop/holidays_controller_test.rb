require "test_helper"

class AdminShop::HolidaysControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get admin_shop_holidays_edit_url
    assert_response :success
  end

  test "should get index" do
    get admin_shop_holidays_index_url
    assert_response :success
  end
end
