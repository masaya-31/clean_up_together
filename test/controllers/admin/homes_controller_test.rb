require "test_helper"

class Admin::HomesControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get admin_homes_search_url
    assert_response :success
  end
end
