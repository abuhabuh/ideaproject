require 'test_helper'

class UserIdeaTimesControllerTest < ActionController::TestCase
  setup do
    @user_idea_time = user_idea_times(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_idea_times)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_idea_time" do
    assert_difference('UserIdeaTime.count') do
      post :create, user_idea_time: @user_idea_time.attributes
    end

    assert_redirected_to user_idea_time_path(assigns(:user_idea_time))
  end

  test "should show user_idea_time" do
    get :show, id: @user_idea_time.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_idea_time.to_param
    assert_response :success
  end

  test "should update user_idea_time" do
    put :update, id: @user_idea_time.to_param, user_idea_time: @user_idea_time.attributes
    assert_redirected_to user_idea_time_path(assigns(:user_idea_time))
  end

  test "should destroy user_idea_time" do
    assert_difference('UserIdeaTime.count', -1) do
      delete :destroy, id: @user_idea_time.to_param
    end

    assert_redirected_to user_idea_times_path
  end
end
