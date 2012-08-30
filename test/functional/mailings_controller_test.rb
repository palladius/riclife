require 'test_helper'

class MailingsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mailings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mailing" do
    assert_difference('Mailing.count') do
      post :create, :mailing => { }
    end

    assert_redirected_to mailing_path(assigns(:mailing))
  end

  test "should show mailing" do
    get :show, :id => mailings(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => mailings(:one).to_param
    assert_response :success
  end

  test "should update mailing" do
    put :update, :id => mailings(:one).to_param, :mailing => { }
    assert_redirected_to mailing_path(assigns(:mailing))
  end

  test "should destroy mailing" do
    assert_difference('Mailing.count', -1) do
      delete :destroy, :id => mailings(:one).to_param
    end

    assert_redirected_to mailings_path
  end
end
