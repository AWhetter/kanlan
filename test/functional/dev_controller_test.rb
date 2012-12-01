require 'test_helper'

class DevControllerTest < ActionController::TestCase
  test "should get sha" do
    get :sha
    assert_response :success
  end

end
