class SessionController < ApplicationController
  before_filter :authorize, :except => [:new, :create]
  
  def new
    session[:user_id] = nil
  end

  def create
  	user = User.find_by_name(params[:name])
    if user and user.password_match(params[:password])
  		session[:user_id] = user.id 
  		redirect_to user, :notice => "Welcome #{user.name}"
  	else
  		redirect_to login_path
  	end
  end

  def destroy
    expire_fragment('frag_cache');
  	session[:user_id] = nil
  	redirect_to login_path
  end
end
