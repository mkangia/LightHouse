require 'spec_helper'


describe State do
	
	fixtures :states

	describe "#new" do
  
  	it "return a new state object" do
    	@state = State.new
    	@state.should be_an_instance_of State
  	end
	
  end


  describe "before saving any state object validates the" do

    before(:each) do
      @state = states(:one)
    end

    it "presence of title" do
      @state.title = nil
      @state.should be_invalid
      @state.save.should be_false
    end


    it "presence of project_id" do
      @state.project_id = nil
      @state.should be_invalid
      @state.save.should be_false
    end
  end


  describe "associates each state object with" do
    
    fixtures :projects
    
    it "its creator" do
      @state = states(:one)      
      @state.project should_not be_nil
      @state.project.name.should eql projects(:test_project).name
    end

  end
end