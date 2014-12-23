require 'test_helper'

class AlgExampleControllerTest < ActionController::TestCase
  test "should get alg1" do
    get :alg1
    assert_response :success
  end

end
