class TicketsController < ApplicationController

  def index
    @tickets = Ticket.search(params[:search_ticket], params[:search_by])
    
    respond_to do |format|
      format.html 
      format.json { render json: @tickets }
    end
  end

  def show
    @ticket = Ticket.find(params[:id])
    @project = Project.find(@ticket.project_id)
    @creator = User.find(@ticket.creator)
    @assigned_to = User.find(@ticket.assigned_to)
    @state = State.find(@ticket.state)
    
    respond_to do |format|
      format.html 
      format.json { render json: @ticket }
    end
  end

  def new
    @ticket = Ticket.new
    @project = Project.find(params[:project_id])
    @user = User.find(session[:user_id])
    @can_assign_to = @project.users + [@project.owner] - [@user]
    @states_for_ticket = State.find(:all, :conditions => ["project_id = ?" , @project.id ])

    respond_to do |format|
      format.html 
      format.json { render json: @ticket }
    end
  end

  def edit
    @ticket = Ticket.find(params[:id])
    @user = User.find(session[:user_id])
    @project = Project.find(params[:project_id])
    @can_assign_to = @project.users + [@project.owner] - [@user]
    @states_for_ticket = @project.states
  end

  def create
    @ticket = Ticket.new(params[:ticket])
    @user = User.find(session[:user_id])
    
    respond_to do |format|
      if @ticket.save
        format.html { redirect_to @user, notice: 'Ticket was successfully created.' }
        format.json { render json: @ticket, status: :created, location: @ticket }
      else
        format.html { render action: "new" }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @ticket = Ticket.find(params[:id])
    @project = Project.find(@ticket.project_id)
    @states_for_ticket = @project.states 
    @user_id = @ticket.user_id
    if params[:ticket]["description"].class == ActionDispatch::Http::UploadedFile
       logger.info("now inside if")
       logger.info(params[:ticket][:description])
       DataFile.save(params[:ticket][:description])
       params[:ticket]["description"] = params[:ticket]["description"].original_filename
    end
    respond_to do |format|
      if @ticket.update_attributes(params[:ticket])
        @ticket.update_attributes(:user_id => @user_id)
        format.html { redirect_to project_path(@ticket.project_id), notice: 'Ticket was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy

    respond_to do |format|
      format.html { redirect_to tickets_url }
      format.json { head :no_content }
    end
  end

  def file_upload(file_params)
    @user = User.find(session[:user_id])
    
  end
end
