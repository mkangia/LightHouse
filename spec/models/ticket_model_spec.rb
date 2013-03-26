require 'spec_helper'


describe Ticket do
	
	fixtures :tickets

	describe "#new" do
  
  	it "return a new ticket object" do
    	@ticket = Ticket.new
    	@ticket.should be_an_instance_of Ticket
  	end
	
  end


  describe "before saving any ticket object validates the" do

    before(:each) do
      @ticket = tickets(:test_ticket)
    end

    it "presence of title" do
      @ticket.title = nil
      @ticket.should be_invalid
      @ticket.save.should be_false
    end


    it "presence of user_id" do
      @ticket.user_id = nil
      @ticket.should be_invalid
      @ticket.save.should be_false
    end

    it "presence of project_id" do
      @ticket.project_id = nil
      @ticket.should be_invalid
      @ticket.save.should be_false
    end
  end


  describe "associates each ticket object with" do
    
    fixtures :users
    
    it "its creator" do
      @ticket = tickets(:test_ticket)      
      @ticket.creator should_not be_nil
      @ticket.creator.name.should eql users(:test_user1).name
    end

  end
end