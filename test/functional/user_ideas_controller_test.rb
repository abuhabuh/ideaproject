require 'test_helper'

class UserIdeasControllerTest < ActionController::TestCase
  setup do
    @user_idea = user_ideas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_ideas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_idea" do
    assert_difference('UserIdea.count') do
      post :create, user_idea: @user_idea.attributes
    end

    assert_redirected_to user_idea_path(assigns(:user_idea))
  end

  test "should show user_idea" do
    get :show, id: @user_idea.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_idea.to_param
    assert_response :success
  end

  test "should update user_idea" do
    put :update, id: @user_idea.to_param, user_idea: @user_idea.attributes
    assert_redirected_to user_idea_path(assigns(:user_idea))
  end

  test "should destroy user_idea" do
    assert_difference('UserIdea.count', -1) do
      delete :destroy, id: @user_idea.to_param
    end

    assert_redirected_to user_ideas_path
  end
end
