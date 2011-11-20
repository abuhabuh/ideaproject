require 'test_helper'

class EventPicturesControllerTest < ActionController::TestCase
  setup do
    @event_picture = event_pictures(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:event_pictures)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create event_picture" do
    assert_difference('EventPicture.count') do
      post :create, event_picture: @event_picture.attributes
    end

    assert_redirected_to event_picture_path(assigns(:event_picture))
  end

  test "should show event_picture" do
    get :show, id: @event_picture.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @event_picture.to_param
    assert_response :success
  end

  test "should update event_picture" do
    put :update, id: @event_picture.to_param, event_picture: @event_picture.attributes
    assert_redirected_to event_picture_path(assigns(:event_picture))
  end

  test "should destroy event_picture" do
    assert_difference('EventPicture.count', -1) do
      delete :destroy, id: @event_picture.to_param
    end

    assert_redirected_to event_pictures_path
  end
end
