require 'test_helper'

class UserControllerTest < ActionController::TestCase
	# get show
  test "should get user" do
	  get(:show, {'name_id' => "existent_name_id"})
  	user = assigns(:user)
	  assert_template :show, "should get view show"
	  assert_template layout: "layouts/application"
	  assert_response :success, "response should be success"
	  assert_not_nil assigns(:user), "should get user"
	  assert_not_nil user['avatar'], "should get user's avatar"
	end

	# post create
	userData = {"name" => "my_name",
	  "email" => "myemail@email.com",
	  "password" => "my_password",
	}

  test "should create user successfully" do
  	setup do
	    @request.headers['Accept'] = Mime::JSON
	    @request.headers['Content-Type'] = Mime::JSON.to_s
	  end

    post :create, { 'name' => userData['name'],
  									'email' => userData['email'],
  									'password' => userData['password'],
  									'password_confirmation' => userData['password']},
  									 :format => "json"
    assert_response :success
    body = JSON.parse(response.body)
    assert_equal "success", body["req"]
  end

  test "should not create user when params not complete" do
  	setup do
	    @request.headers['Accept'] = Mime::JSON
	    @request.headers['Content-Type'] = Mime::JSON.to_s
	  end

	  # no name
    post :create, { 'name' => '',
  									'email' => userData['email'],
  									'password' => userData['password'],
  									'password_confirmation' => userData['password']},
  									 :format => "json"
    assert_response :success
    body = JSON.parse(response.body)
    assert_equal "error", body["req"]

    # no email
    post :create, { 'name' => userData['name'],
  									'email' => '',
  									'password' => userData['password'],
  									'password_confirmation' => userData['password']},
  									 :format => "json"
    assert_response :success
    body = JSON.parse(response.body)
    assert_equal "error", body["req"]

    # no password
    post :create, { 'name' => userData['name'],
  									'email' => userData['email'],
  									'password' => '',
  									'password_confirmation' => userData['password']},
  									 :format => "json"
    assert_response :success
    body = JSON.parse(response.body)
    assert_equal "error", body["req"]

    # no password_confirmation
    post :create, { 'name' => userData['name'],
  									'email' => userData['email'],
  									'password' => userData['password'],
  									'password_confirmation' => ''},
  									 :format => "json"
    assert_response :success
    body = JSON.parse(response.body)
    assert_equal "error", body["req"]
  end

  # password not match
  test "should not create user when password not match" do
  	setup do
	    @request.headers['Accept'] = Mime::JSON
	    @request.headers['Content-Type'] = Mime::JSON.to_s
	  end

    post :create, { 'name' => userData['name'],
  									'email' => userData['email'],
  									'password' => userData['password'],
  									'password_confirmation' => userData['password'] + 'xxx'},
  									 :format => "json"
    assert_response :success
    body = JSON.parse(response.body)
    assert_equal "error", body["req"]
  end
end
