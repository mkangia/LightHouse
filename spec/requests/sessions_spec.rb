require 'spec_helper'

describe "Sessions" do
  describe "GET /sessions" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get login_path
      response.status.should be(200)
    end

    it "has content LightHouse" do
      visit '/'
      page.should have_content('Beautiful and simple issue tracking system')
    end

    it "should have the righ title" do
      visit '/'
      page.should have_selector('title', :text => "LightHouse")
    end
  end
end
