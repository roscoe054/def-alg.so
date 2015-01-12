require 'test_helper'

class UserControllerTest < ActionController::TestCase
  test "should get user" do
	  get(:show, {'name_id' => "123"})
	  assert_template :show
	  assert_template layout: "layouts/application"
	  assert_response :success
	  assert_not_nil assigns(:user)
	end

  test "should get 404" do
	  get(:show, {'name_id' => "notExists"})
	  assert_response :redirect
	end
end
