require 'test_helper'

class KeyvalsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:keyvals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create keyval" do
    assert_difference('Keyval.count') do
      post :create, :keyval => { }
    end

    assert_redirected_to keyval_path(assigns(:keyval))
  end

  test "should show keyval" do
    get :show, :id => keyvals(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => keyvals(:one).to_param
    assert_response :success
  end

  test "should update keyval" do
    put :update, :id => keyvals(:one).to_param, :keyval => { }
    assert_redirected_to keyval_path(assigns(:keyval))
  end

  test "should destroy keyval" do
    assert_difference('Keyval.count', -1) do
      delete :destroy, :id => keyvals(:one).to_param
    end

    assert_redirected_to keyvals_path
  end
end
