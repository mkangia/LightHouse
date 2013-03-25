require 'spec_helper'

describe UsersController do
	
	fixtures :users
	describe "checks for authorization" do
		
		it "for users home page" do
			user = users(:test_user1)
			get user_path(user.id)
			response.should redirect_to login_path
		end

		it "not needed for new user page" do
			get new_user_path
			response.should be_success
		end
  
  end
  
  describe "after log in" do 
	
		describe "users home page" do
			
			before(:each) do 
				@user = users(:test_user1)
				post_via_redirect "login",:name => @user.name, :password => @user.password_digest
			end
			
			it "has email as a label" do
			  response.body.should have_selector 'label', :text => @user.email
			end

			it "has a form to search projects" do
    		response.body.should have_selector "#search_by_project form", :count => 1
		  end

		  it "has a form to search tickets" do
    		response.body.should have_selector "#search_by_ticket form", :count => 1
		  end

		  it "displays link to the projects owned by the user" do 
				@projects = @user.projects
				@projects.each { |project| response.body.should have_selector 'a', :text => project.name }
		  end

		  it "displays link to all projects assigned to the user" do
		  	@user.projects.each { |project| response.body.should have_selector 'a', project.name }
		  end

		  it "displays link to all the tickets assigned to the user" do 
		  	response.body.should have_selector '#tickets ul.tickets_assigned li', :count => @user.tickets.count
				@user.tickets.each { |ticket| response.body.should have_selector '#tickets ul.tickets_assigned li', :text => ticket.title }
		  end

		  it "displays a welcome note on login" do
		  	response.body.should have_selector 'p', :text => "Welcome #{@user.name}"
		  end

		  it "has a link to Account/Home Page" do
		  	response.body.should have_selector 'a', :text => "Home"
		  	response.body.should have_selector 'a', :text => "Account"
		  end

		  it "has a logout button" do
		  	response.body.should have_selector 'a', :text => "Logout"
		  end

		end
	
  end

end