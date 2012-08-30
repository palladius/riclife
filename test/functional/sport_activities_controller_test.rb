require 'test_helper'

class SportActivitiesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sport_activities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sport_activity" do
    assert_difference('SportActivity.count') do
      post :create, :sport_activity => { }
    end

    assert_redirected_to sport_activity_path(assigns(:sport_activity))
  end

  test "should show sport_activity" do
    get :show, :id => sport_activities(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => sport_activities(:one).to_param
    assert_response :success
  end

  test "should update sport_activity" do
    put :update, :id => sport_activities(:one).to_param, :sport_activity => { }
    assert_redirected_to sport_activity_path(assigns(:sport_activity))
  end

  test "should destroy sport_activity" do
    assert_difference('SportActivity.count', -1) do
      delete :destroy, :id => sport_activities(:one).to_param
    end

    assert_redirected_to sport_activities_path
  end
end
