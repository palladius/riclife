require 'test_helper'

class NotesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:notes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create notes" do
    assert_difference('Notes.count') do
      post :create, :notes => { }
    end

    assert_redirected_to notes_path(assigns(:notes))
  end

  test "should show notes" do
    get :show, :id => notes(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => notes(:one).id
    assert_response :success
  end

  test "should update notes" do
    put :update, :id => notes(:one).id, :notes => { }
    assert_redirected_to notes_path(assigns(:notes))
  end

  test "should destroy notes" do
    assert_difference('Notes.count', -1) do
      delete :destroy, :id => notes(:one).id
    end

    assert_redirected_to notes_path
  end
end
