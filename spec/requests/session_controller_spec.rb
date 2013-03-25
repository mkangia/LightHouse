require 'spec_helper'

describe SessionController do
  fixtures :users
  describe "the login page" do
    
    it "renders the new template" do
      get "login"
      response.should render_template("new")
    end

    it "has the title LightHouse" do
      visit '/'
      page.should have_selector('title', :text => "LightHouse")
    end

    it "has a login form" do
      visit '/'
      page.should have_selector('form',:count => 1)
    end
    
    it "has verified headings" do
      visit '/'
      page.should have_selector('h1', :text => "Light and simple issue tracking system")
      page.should have_selector('h1', :text => "More fun, More functions")
      page.should have_selector('h1', :text => "Consolidate your projects")
      page.should have_selector('h1', :count => 3)
    end
    

    it "redirects back to home page for unknown user successfully" do
      post "login",:name => "puppy", :password => "puppy"
      response.should be_redirect 
      response.should redirect_to login_path
    end

    
    it "logins successfully and sets the session" do
      user = users(:test_user1)
      post "login",:name => user.name, :password => user.password_digest
      response.should be_redirect 
      response.should redirect_to user
      assert_equal session[:user_id], user.id 
    end
    
    it "has a working link to about page" do
      visit '/'
      page.should have_selector('a', :text => "Learn more", :href => "/about")
      click_link "Learn more"
      page.should have_selector('h2', :text => "Keep up with your project on the go")
    end


    it "has a working link to try lighthouse" do
      visit '/'
      page.should have_selector('a', :text => "Try Lighthouse", :href => "/users/new")
      click_link "Try Lighthouse"
      page.should have_selector('h1', :text => "New user")
    end
  end

  describe "on logout" do
    it "logs out successfully and sets session to nil" do
      post "login",:name => "puppy", :password => "MyString"
      delete "logout"
      response.should be_redirect 
      response.should redirect_to login_path
      assert session[:user_id].nil?
    end
  end

  describe "authorizes logout through session and redirects to log-in" do
    it "it checks for current session on logout" do
      get 'login'
      assert session[:user_id].nil?
      delete "logout"
      response.should redirect_to login_path
    end
  end
  
end
