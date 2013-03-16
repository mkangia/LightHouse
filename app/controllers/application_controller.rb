class ApplicationController < ActionController::Base
  protect_from_forgery
  
  protected
  
  def authorize
    redirect_to login_path if session[:user_id].nil?
  end
  
  def get_user
  	User.find(session[:user_id])
  end

  def get_projects
  	Project.all
  end
end
