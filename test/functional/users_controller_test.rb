require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:test_user1)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create new user" do
    assert_difference('User.count') do
      post :create, user: { email: "valid@email.com", name: "pinky", password_digest: "pinky" }
    end
  
    assert_response :redirect
    assert_redirected_to login_url
  end

  test "should not create duplicate user" do
    assert_no_difference('User.count') do
      post :create, user: { email: @user.email, name: @user.name, password_digest: @user.password_digest }
    end

    assert_response :success
    assert_select "#error_explanation ul li", 1
  end
  
  test "should not create user with invalid email-id" do
    @user = users(:test_user2)
    assert_no_difference('User.count') do
      post :create, user: { email: @user.email, name: @user.name, password_digest: @user.password_digest }
    end
    
    assert_response :success
    assert_select "#error_explanation ul li", 1
  end

  test "should show user" do
    session[:user_id] = @user.id
    get :show, id: @user
    assert_response :success
  end

  test "should not show user if not in session" do
    get :show, id: @user
    
    assert_response :redirect
    assert_redirected_to login_url
  end

  test "should get edit" do
    session[:user_id] = @user.id;
    get :edit, id: @user
    assert_response :success
  end


  test "should not get edit if not in session" do
    get :edit, id: @user

    assert_response :redirect
    assert_redirected_to login_url
  end

  test "should update user" do
    session[:user_id] = @user.id;
    put :update, id: @user, user: { email: @user.email, name: @user.name, password_digest: @user.password_digest }
    
    assert_response :redirect
    assert_redirected_to login_path
  end


  test "should not update user if not in session" do
    put :update, id: @user, user: { email: @user.email, name: @user.name, password_digest: @user.password_digest }
    assert_redirected_to login_path
  end

end
