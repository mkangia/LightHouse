require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
	fixtures :users

	test "successful login" do
		https!
		get "/login"
		assert_response :success
    
    @user = users(:test_user1)
		post_via_redirect "/login", :name => @user.name, :password => @user.password_digest
    assert_equal "/users/#{@user.id}", path
    assert_equal "Welcome #{@user.name}", flash[:notice]
	end

	test "Unsuccessful login" do
		https!
		post_via_redirect "/login"
		assert_response :success
		assert_equal "/login", path
	end


  # test "login and browse site" do
 
  #   # User avs logs in
  #   avs = login(:test_user1)
  #   # User guest logs in
  #   guest = login(:test_user2)
 
  #   # Both are now available in different sessions
  #   assert_equal "Welcome #{test_user1.name}", avs.flash[:notice]
  #   assert_equal "Welcome #{test_user2.name}", guest.flash[:notice]
 
  #   # User avs can browse site
  #   avs.browses_site
  #   # User guest can browse site as well
  #   guest.browses_site
 
  #   # Continue with other assertions
  # end
 
  # private
 
  # module CustomDsl
  #   def browses_site
  #     get "/lighthouse/all"
  #     assert_response :success
  #   end
  # end
 
  # def login(user)
  #   open_session do |sess|
  #     sess.extend(CustomDsl)
  #     u = users(user)
  #     sess.https!
  #     sess.post_via_redirect "/login", :name => u.name, :password => u.password_digest
  #     assert_equal "/users/#{u.id}", path
  #     sess.https!(false)
  #   end
  # end
end