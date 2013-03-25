require 'spec_helper.rb'

describe StatesController do
	
	describe "checks for authorization" do
		it "for new state and in case of no authorization via session redirects to login page" do
			get new_state_path
			response.should be_redirect 
			response.should redirect_to login_path
		end

		it "for edit state and in case of no authorization via session redirects to login page" do
			get edit_state_path(1)
			response.should be_redirect
			response.should redirect_to login_path
		end

		it "for index state and in case of no authorization via session redirects to login page" do
			get states_path
			response.should be_redirect
			response.should redirect_to login_path
		end

	end

	describe "after successful login" do
		fixtures :users
		fixtures :projects
		fixtures :states
		before (:each) do
			get 'login'
			@user = users(:test_user1)
			post_via_redirect "login",:name => @user.name, :password => @user.password_digest
			@project = projects(:test_project)
			@state = states(:one)
	  end

	  it "does not allow for a new state without project id" do
			expect { new }.to raise_error
		end

		it "allows for a new state with project_id in params" do
			get new_state_path({ :project_id => @project.id })
			response.should be_success
		end

	  it "does not allow to edit a state without project id" do
			expect { edit }.to raise_error
		end

		it "allows to edit state with project_id in params" do
			get edit_state_path(@state)
			response.should be_success
		end

	  it "does not allow to view index page without project id" do
			expect { index }.to raise_error
		end

		it "allows to view index page for state" do
			get states_path({:project_id => @state.project_id})
			response.should be_success
		end


	  it "does not allow to create state without project id" do
			expect { create }.to raise_error
		end

  end
end