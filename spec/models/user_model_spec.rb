require 'spec_helper'

describe User do
	
	fixtures :users

	describe "#new" do
  	
  	it "return a new user object" do
    	@user = User.new
    	@user.should be_an_instance_of User
  	end

	end

	describe "before saving any user object validates the" do

		before(:each) do
			@user = users(:test_user1)
    end

    it "presence of name" do
			@user.name = nil
			@user.should be_invalid
			@user.save.should be_false
		end


    it "presence of password" do
			@user.password_digest = nil
			@user.should be_invalid
			@user.save.should be_false
		end


    it "presence of email" do
			@user.email = nil
			@user.should be_invalid
			@user.save.should be_false
		end

		it "format of email" do
			@user.email = "invalid"
			@user.should be_invalid
			@user.save.should be_false
		end
	end

	describe "associates each user object with" do

		before(:each) do
			@user = users(:test_user1)
    end

    it "projects" do
    	@user.projects.should_not be_nil
    	@user.should have(1).projects
    end


    it "tickets" do
    	@user.tickets.should_not be_nil
    	@user.should have(1).tickets
    end

	end

	describe "#password_match" do

		context "checks for the password entered" do

			before(:each) do
				@user = users(:test_user1)
	    end
			
			it "returns true if matches" do
				@user.password_match(@user.password_digest).should be_true
			end

			it "returns false if does not match" do
				@user.password_match("abra-ka-dabra").should be_false
			end

	  end
	end
end