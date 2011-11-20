require 'test_helper'

class IdeaEventsControllerTest < ActionController::TestCase
  setup do
    @idea_event = idea_events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:idea_events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create idea_event" do
    assert_difference('IdeaEvent.count') do
      post :create, idea_event: @idea_event.attributes
    end

    assert_redirected_to idea_event_path(assigns(:idea_event))
  end

  test "should show idea_event" do
    get :show, id: @idea_event.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @idea_event.to_param
    assert_response :success
  end

  test "should update idea_event" do
    put :update, id: @idea_event.to_param, idea_event: @idea_event.attributes
    assert_redirected_to idea_event_path(assigns(:idea_event))
  end

  test "should destroy idea_event" do
    assert_difference('IdeaEvent.count', -1) do
      delete :destroy, id: @idea_event.to_param
    end

    assert_redirected_to idea_events_path
  end
end
