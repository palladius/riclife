require 'test_helper'

class PhotoTypesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:photo_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create photo_type" do
    assert_difference('PhotoType.count') do
      post :create, :photo_type => { }
    end

    assert_redirected_to photo_type_path(assigns(:photo_type))
  end

  test "should show photo_type" do
    get :show, :id => photo_types(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => photo_types(:one).to_param
    assert_response :success
  end

  test "should update photo_type" do
    put :update, :id => photo_types(:one).to_param, :photo_type => { }
    assert_redirected_to photo_type_path(assigns(:photo_type))
  end

  test "should destroy photo_type" do
    assert_difference('PhotoType.count', -1) do
      delete :destroy, :id => photo_types(:one).to_param
    end

    assert_redirected_to photo_types_path
  end
end
