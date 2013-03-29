require 'test_helper'

class StatesControllerTest < ActionController::TestCase
  setup do
    session[:user_id] = 1
    @state = states(:one)
  end

  test "should get index" do
    get :index, :project_id => 1
    assert_response :success
    assert_not_nil assigns(:states)
  end

  test "should get new" do
    get :new, :project_id => 1
    assert_response :success
  end

  test "should create state" do
    assert_difference('State.count') do
      post :create, state: { open: @state.open, project_id: @state.project_id, title: @state.title }
    end

    assert_redirected_to project_path(@state.project_id)
  end

  test "should get edit" do
    get :edit, id: @state, :project_id => 1
    assert_response :success
  end

  test "should update state" do
    put :update, id: @state, state: { open: @state.open, project_id: @state.project_id, title: @state.title }
    assert_redirected_to project_path(@state.project_id)
  end

  test "should not destroy state if there is an associated ticket with it" do
    @request.env["HTTP_REFERER"] = states_path(:project_id => @state.project_id)
    assert_difference('State.count', 0) do
      delete :destroy, id: @state
    end

    assert_redirected_to states_path(:project_id => @state.project_id)
  end


  test "should destroy state if there is no associated ticket with it" do
    @state = states(:two)
    @request.env["HTTP_REFERER"] = states_path(:project_id => @state.project_id)
    assert_difference('State.count', -1) do
      delete :destroy, id: @state
    end

    assert_redirected_to states_path(:project_id => @state.project_id)
  end

end
