require "test_helper"

class AdminShop::NoticesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_shop_notices_index_url
    assert_response :success
  end

  test "should get edit" do
    get admin_shop_notices_edit_url
    assert_response :success
  end
end
