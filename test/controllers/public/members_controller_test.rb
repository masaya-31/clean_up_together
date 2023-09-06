require "test_helper"

class Public::MembersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_members_show_url
    assert_response :success
  end

  test "should get follows" do
    get public_members_follows_url
    assert_response :success
  end

  test "should get edit" do
    get public_members_edit_url
    assert_response :success
  end

  test "should get email_edit" do
    get public_members_email_edit_url
    assert_response :success
  end

  test "should get password_edit" do
    get public_members_password_edit_url
    assert_response :success
  end
end
