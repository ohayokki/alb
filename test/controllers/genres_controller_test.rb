require "test_helper"

class GenresControllerTest < ActionDispatch::IntegrationTest
  test "should get area" do
    get genres_area_url
    assert_response :success
  end
end
