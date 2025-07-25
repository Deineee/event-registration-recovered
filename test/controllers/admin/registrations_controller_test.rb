require "test_helper"

class Admin::RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_registrations_index_url
    assert_response :success
  end

  test "should get edit" do
    get admin_registrations_edit_url
    assert_response :success
  end
end
