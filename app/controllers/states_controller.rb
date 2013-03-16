class StatesController < ApplicationController
  
  def show
    @states = State.where(:project_id => (params[:project_id]))
    @project = Project.find(params[:project_id])
    respond_to do |format|
      format.html
      format.json { render json: @state }
    end
  end

  def new
    @state = State.new
    
    respond_to do |format|
      format.html
      format.json { render json: @state }
    end
  end
  
  def index
    @states = State.where(:project_id => (params[:project_id]))
    @project = Project.find(params[:project_id])
    respond_to do |format|
      format.html
      format.json { render json: @state }
    end
  end
  def edit
    @state = State.find(params[:id])
  end

  def create
    @state = State.new(params[:state])
    
    respond_to do |format|
      if @state.save
        format.html { redirect_to project_path(@state.project_id), notice: 'State was successfully created.' }
        format.json { render json: @state, status: :created, location: @state }
      else
        format.html { render action: "new" }
        format.json { render json: @state.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @state = State.find(params[:id])
    @project = @state.project
    respond_to do |format|
      if @state.update_attributes(params[:state])
        format.html { redirect_to @project, notice: 'State was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @state.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @state = State.find(params[:id])
    @state.destroy
    
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end
end
