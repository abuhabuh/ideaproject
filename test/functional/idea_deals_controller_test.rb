require 'test_helper'

class IdeaDealsControllerTest < ActionController::TestCase
  setup do
    @idea_deal = idea_deals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:idea_deals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create idea_deal" do
    assert_difference('IdeaDeal.count') do
      post :create, idea_deal: @idea_deal.attributes
    end

    assert_redirected_to idea_deal_path(assigns(:idea_deal))
  end

  test "should show idea_deal" do
    get :show, id: @idea_deal.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @idea_deal.to_param
    assert_response :success
  end

  test "should update idea_deal" do
    put :update, id: @idea_deal.to_param, idea_deal: @idea_deal.attributes
    assert_redirected_to idea_deal_path(assigns(:idea_deal))
  end

  test "should destroy idea_deal" do
    assert_difference('IdeaDeal.count', -1) do
      delete :destroy, id: @idea_deal.to_param
    end

    assert_redirected_to idea_deals_path
  end
end
