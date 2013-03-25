require 'spec_helper'

describe ProjectsController do
	
	describe "checks for authorization" do
		it "for new project and in case of no authorization via session redirects to login page" do
			get new_project_path
			response.should be_redirect 
			response.should redirect_to login_path
		end

		it "for all project and in case of no authorization via session redirects to login page" do
			get lighthouse_all_path
			response.should be_redirect
			response.should redirect_to  login_path
		end

		it "for edit project and in case of no authorization via session redirects to login page" do
			get edit_project_path(1)
			response.should be_redirect
			response.should redirect_to login_path
		end

		it "for index project and in case of no authorization via session redirects to login page" do
			get projects_path
			response.should be_redirect
			response.should redirect_to login_path
		end

		it "for show project and in case of no authorization via session redirects to login page" do
			get project_path(1)
			response.should be_redirect
			response.should redirect_to login_path
		end
	end

	describe "after successful login" do
		fixtures :users
		fixtures :projects
		before (:each) do
			get 'login'
			@user = users(:test_user1)
			post_via_redirect "login",:name => @user.name, :password => @user.password_digest
			@project = projects(:test_project)
		end

		it "allows for a new project" do
			get new_project_path
			response.should be_success
		end

		it "allows to view all project under lighthouse" do
			get lighthouse_all_path
			response.should be_success
		end

		it "allows to edit project" do
			get edit_project_path(@project)
			response.should be_success
		end

		it "allows to view index page for project" do
			get projects_path
			response.should be_success
		end

		it "allows to view details of a particular project" do
			get project_path(@project)
			response.should be_success
		end

		it "has a search feature to look for a project having a certain title/name" do
 			get projects_path({:search => "MyProject"})
 			response.should be_success
 			response.body.should have_link("MyProject")
		end
	end
end