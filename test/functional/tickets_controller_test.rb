require 'test_helper'

class TicketsControllerTest < ActionController::TestCase
  
  setup do
    session[:user_id] = 1
    @ticket = tickets(:test_ticket)
  end

  test "should get index" do
    get :index, :search_ticket => "vinsol", :search_by => "all"
    assert_response :success
    assert_not_nil assigns(:tickets)
  end

  test "should get new" do
    get :new, :project_id => 1
    assert_response :success
  end

  test "should create ticket" do
    assert_difference('Ticket.count') do
      post :create, ticket: { assigned_to: @ticket.assigned_to, description: @ticket.description, project_id: @ticket.project_id, state: @ticket.state, title: @ticket.title, user_id: @ticket.user_id }
    end

     assert_redirected_to user_path(session[:user_id])
  end

  test "should show ticket" do
    get :show, id: @ticket
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ticket, :project_id => @ticket.project_id
    assert_response :success
  end

  test "should update ticket" do
    put :update, id: @ticket, ticket: { assigned_to: @ticket.assigned_to, description: @ticket.description, project_id: @ticket.project_id, state: @ticket.state, title: @ticket.title, user_id: @ticket.user_id }
    assert_redirected_to project_path(@ticket.project_id)
  end

  test "should destroy ticket" do
    assert_difference('Ticket.count', -1) do
      delete :destroy, id: @ticket
    end

    assert_redirected_to user_path(session[:user_id])
  end
end
