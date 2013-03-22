require 'test_helper'

class SessionControllerTest < ActionController::TestCase
  test "should get new" do
    get 'new'
    assert_response :success
  end
  
  test "should be redirected to login" do
    post 'create'
    assert_redirected_to login_path
  end

  test "should fail login" do
    post 'create', :name => "anything", :password => "something"
    assert_redirected_to login_path
    assert session[:user_id].nil?
  end

  test "should get create" do
    user = users(:test_user1)
    post 'create', :name => user.name, :password => user.password_digest 
    assert_redirected_to user
    assert_equal session[:user_id],user.id
  end

  test "should get destroy" do
    delete :destroy
    assert_redirected_to login_url
  end

end
