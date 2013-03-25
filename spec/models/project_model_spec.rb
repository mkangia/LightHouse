require 'spec_helper'

describe Project do
	
	fixtures :projects

	describe "#new" do
  	
  	it "return a new project object" do
    	@project = Project.new
    	@project.should be_an_instance_of Project
  	end

	end


	describe "before saving any project object validates the" do

		before(:each) do
			@project = projects(:test_project)
    end

    it "presence of name" do
			@project.name = nil
			@project.should be_invalid
			@project.save.should be_false
		end


    it "presence of user_id" do
			@project.user_id = nil
			@project.should be_invalid
			@project.save.should be_false
		end
	end

	describe "associates each project object with" do

		before(:each) do
			@project = projects(:test_project)
    end


    it "tickets" do
    	@project.tickets.should_not be_nil
    	@project.should have(1).tickets
    end

    it "states" do
    	@project.states.should_not be_nil
    	@project.should have(2).states
    end

    it "users" do
    	@project.users.should_not be_nil
    	@project.should have(2).users
    end
  end

  describe "for each new project created" do
  	it "add two default states " do
  		@new_project = Project.create(:name => "project", :user_id => 1, :description => "escapar")
  		@new_project.should have(2).states
  	end
  end
end