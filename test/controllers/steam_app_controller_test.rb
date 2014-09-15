require 'test_helper'

class SteamAppControllerTest < ActionController::TestCase
  test "should get suggest" do
    get :suggest
    assert_response :success
  end

end
