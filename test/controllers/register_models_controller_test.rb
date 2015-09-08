require 'test_helper'

class RegisterModelsControllerTest < ActionController::TestCase
  setup do
    @register_model = register_models(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:register_models)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create register_model" do
    assert_difference('RegisterModel.count') do
      post :create, register_model: { explanation: @register_model.explanation, name: @register_model.name }
    end

    assert_redirected_to register_model_path(assigns(:register_model))
  end

  test "should show register_model" do
    get :show, id: @register_model
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @register_model
    assert_response :success
  end

  test "should update register_model" do
    patch :update, id: @register_model, register_model: { explanation: @register_model.explanation, name: @register_model.name }
    assert_redirected_to register_model_path(assigns(:register_model))
  end

  test "should destroy register_model" do
    assert_difference('RegisterModel.count', -1) do
      delete :destroy, id: @register_model
    end

    assert_redirected_to register_models_path
  end
end
