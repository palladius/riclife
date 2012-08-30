require 'test_helper'

class GugolCalendarsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gugol_calendars)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gugol_calendar" do
    assert_difference('GugolCalendar.count') do
      post :create, :gugol_calendar => { }
    end

    assert_redirected_to gugol_calendar_path(assigns(:gugol_calendar))
  end

  test "should show gugol_calendar" do
    get :show, :id => gugol_calendars(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => gugol_calendars(:one).to_param
    assert_response :success
  end

  test "should update gugol_calendar" do
    put :update, :id => gugol_calendars(:one).to_param, :gugol_calendar => { }
    assert_redirected_to gugol_calendar_path(assigns(:gugol_calendar))
  end

  test "should destroy gugol_calendar" do
    assert_difference('GugolCalendar.count', -1) do
      delete :destroy, :id => gugol_calendars(:one).to_param
    end

    assert_redirected_to gugol_calendars_path
  end
end
