require "test_helper"

class AdminShop::StaffsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get admin_shop_staffs_edit_url
    assert_response :success
  end
end
