require "test_helper"

class StaffsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get staffs_show_url
    assert_response :success
  end
end
