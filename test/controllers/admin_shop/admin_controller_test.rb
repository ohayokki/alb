require "test_helper"

class AdminShop::AdminControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_shop_admin_index_url
    assert_response :success
  end
end
