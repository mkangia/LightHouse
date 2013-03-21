class UsersController < ApplicationController
  
  before_filter :authorize, :except => [:new, :create]
  def show
    @user = User.find(params[:id])
    @projects_owned = Project.find(:all, :conditions => ["user_id = #{@user.id}"])
    @projects_assigned = [@user.projects].flatten.uniq
    @tickets_assigned = @user.tickets
    @ticket_attributes = Ticket.attribute_names
    
    respond_to do |format|
      format.html 
      format.json { render json: @user }
    end
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html 
      format.json { render json: @user }
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user = User.find(params[:id])
    
    respond_to do |format|
      if @user.update_attributes(params[:user])
        expire_action :action => :edit
        session[:user_id] = nil
        format.html { redirect_to login_url }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
end
