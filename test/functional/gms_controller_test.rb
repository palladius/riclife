require 'test_helper'

class GmsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gm" do
    assert_difference('Gm.count') do
      post :create, :gm => { }
    end

    assert_redirected_to gm_path(assigns(:gm))
  end

  test "should show gm" do
    get :show, :id => gms(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => gms(:one).to_param
    assert_response :success
  end

  test "should update gm" do
    put :update, :id => gms(:one).to_param, :gm => { }
    assert_redirected_to gm_path(assigns(:gm))
  end

  test "should destroy gm" do
    assert_difference('Gm.count', -1) do
      delete :destroy, :id => gms(:one).to_param
    end

    assert_redirected_to gms_path
  end
end
