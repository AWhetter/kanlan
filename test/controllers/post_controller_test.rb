require 'test_helper'

class PostControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get add_user" do
    get :add_user
    assert_response :success
  end

  test "should get rm_user" do
    get :rm_user
    assert_response :success
  end

end
