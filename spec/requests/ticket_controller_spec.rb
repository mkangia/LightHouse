require 'spec_helper'


describe TicketsController do
	
	describe "checks for authorization" do
		it "for new ticket and in case of no authorization via session redirects to login page" do
			get new_ticket_path
			response.should be_redirect 
			response.should redirect_to login_path
		end

		it "for edit ticket and in case of no authorization via session redirects to login page" do
			get edit_ticket_path(1)
			response.should be_redirect
			response.should redirect_to login_path
		end

		it "for index state and in case of no authorization via session redirects to login page" do
			get tickets_path
			response.should be_redirect
			response.should redirect_to login_path
		end


		it "for show ticket and in case of no authorization via session redirects to login page" do
			get ticket_path(1)
			response.should be_redirect
			response.should redirect_to login_path
		end

	end

	describe "after successful login" do
		fixtures :users
		fixtures :projects
	  fixtures :tickets
		
		before (:each) do
			get 'login'
			@user = users(:test_user1)
			post_via_redirect "login",:name => @user.name, :password => @user.password_digest
			@project = projects(:test_project)
			@ticket = tickets(:test_ticket)
	  end

	  it "does not allow for a new state without project id" do
			expect { new }.to raise_error
		end

		it "allows for a new state with project_id in params" do
			get new_ticket_path({ :project_id => @project.id })
			response.should be_success
		end

		it "allows to edit state with project_id in params" do
			get edit_ticket_path({ :id => @ticket.id, :project_id => @project.id})
			response.should be_success
		end

	  it "does not allow to edit a state without project id" do
			expect { edit }.to raise_error
		end

		it "throws an error on a request to index index page without search parameters" do
			expect { index }.to raise_error
		end

	  it "does not allow to create state without project id" do
			expect { create }.to raise_error
		end

  end
end