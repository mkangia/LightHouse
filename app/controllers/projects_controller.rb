class ProjectsController < ApplicationController
  before_filter :authorize

  caches_action :all_projects, :layout => false
  def index
    @projects = Project.search(params[:search])

    respond_to do |format|
      format.html 
      format.json { render json: @projects }
    end
  end

  def show
    @project = Project.find(params[:id])
    @tickets_for_project = @project.tickets
    if p = ProjectsUser.find(:first,:conditions => ["user_id = ? AND project_id = ?", session[:user_id], @project.id])
      @admin = p.admin ? true : false
    end
    
    @admin = (@project.owner.id == session[:user_id]) unless @admin
    respond_to do |format|
      format.html 
      format.json { render json: @project }
    end
  end

  def new
    @project = Project.new

    respond_to do |format|
      format.html 
      format.json { render json: @project }
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def create
    @project = Project.new(params[:project])
    @project.user_id = session[:user_id] 
    user = User.find(session[:user_id])
    respond_to do |format|
      if @project.save
        expire_fragment('user_project_cache')
        expire_action :action => :all_projects
        format.html { redirect_to user, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to users_url(session[:user_id]) }
      format.json { head :no_content }
    end
  end

  def assign_projects
    @project = Project.find(params[:id])
    InvitesEmail.delay.invites(@project.owner, User.find(session[:user_id]))

    # invites_to = params[:emails].split(',')
    # invites_to = invites_to.select { |email| email.match(/^[a-zA-z0-9]+[\w\.]*\w+@\w+\.[a-zA-Z]{2,3}$/i) }
    
    # invites_to.each do |email|
    #   if (user = User.find_by_email(email) )
    #     user.projects << @project 
    #     user.save
    #     p = ProjectsUser.find(:first,:conditions => ["user_id = ? AND project_id = ?",user.id, @project.id])
    #     p.admin = params[:admin_role] || 0
    #     p.save 
    #   end
    # end

    redirect_to user_path(session[:user_id])
  end

  def all_projects
    @projects = Project.all
  end

end
