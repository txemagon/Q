require 'test_helper'

class BoardControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get welcome" do
    get :welcome
    assert_response :success
  end

  test "should get banish" do
    get :banish
    assert_response :success
  end

end
