require "test_helper"

class Public::CategoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_categories_show_url
    assert_response :success
  end
end
