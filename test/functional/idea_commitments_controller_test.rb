require 'test_helper'

class IdeaCommitmentsControllerTest < ActionController::TestCase
  setup do
    @idea_commitment = idea_commitments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:idea_commitments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create idea_commitment" do
    assert_difference('IdeaCommitment.count') do
      post :create, idea_commitment: @idea_commitment.attributes
    end

    assert_redirected_to idea_commitment_path(assigns(:idea_commitment))
  end

  test "should show idea_commitment" do
    get :show, id: @idea_commitment.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @idea_commitment.to_param
    assert_response :success
  end

  test "should update idea_commitment" do
    put :update, id: @idea_commitment.to_param, idea_commitment: @idea_commitment.attributes
    assert_redirected_to idea_commitment_path(assigns(:idea_commitment))
  end

  test "should destroy idea_commitment" do
    assert_difference('IdeaCommitment.count', -1) do
      delete :destroy, id: @idea_commitment.to_param
    end

    assert_redirected_to idea_commitments_path
  end
end
