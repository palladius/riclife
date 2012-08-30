require 'test_helper'

class RicfilesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ricfiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ricfile" do
    assert_difference('Ricfile.count') do
      post :create, :ricfile => { }
    end

    assert_redirected_to ricfile_path(assigns(:ricfile))
  end

  test "should show ricfile" do
    get :show, :id => ricfiles(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => ricfiles(:one).to_param
    assert_response :success
  end

  test "should update ricfile" do
    put :update, :id => ricfiles(:one).to_param, :ricfile => { }
    assert_redirected_to ricfile_path(assigns(:ricfile))
  end

  test "should destroy ricfile" do
    assert_difference('Ricfile.count', -1) do
      delete :destroy, :id => ricfiles(:one).to_param
    end

    assert_redirected_to ricfiles_path
  end
end
