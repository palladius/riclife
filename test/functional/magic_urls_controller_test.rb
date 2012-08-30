require 'test_helper'

class MagicUrlsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:magic_urls)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create magic_url" do
    assert_difference('MagicUrl.count') do
      post :create, :magic_url => { }
    end

    assert_redirected_to magic_url_path(assigns(:magic_url))
  end

  test "should show magic_url" do
    get :show, :id => magic_urls(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => magic_urls(:one).to_param
    assert_response :success
  end

  test "should update magic_url" do
    put :update, :id => magic_urls(:one).to_param, :magic_url => { }
    assert_redirected_to magic_url_path(assigns(:magic_url))
  end

  test "should destroy magic_url" do
    assert_difference('MagicUrl.count', -1) do
      delete :destroy, :id => magic_urls(:one).to_param
    end

    assert_redirected_to magic_urls_path
  end
end
