class ApplicationController < ActionController::Base
  protect_from_forgery
  
  protected
  
  def authorize
    redirect_to login_path if session[:user_id].nil?
  end
 
end
