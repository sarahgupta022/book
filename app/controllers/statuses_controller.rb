class StatusesController < ApplicationController
  before_action :set_status, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update]
  
rescue_from ActiveModel::MassAssignmentSecurity::Error, with: :render_permission_error , formats: [:html]
 
  
  # GET /statuses
  # GET /statuses.json
  def index
    @statuses = Status.order('created_at desc').all

     respond_to do |format|
      format.html #index.html.erb
      format.json { render json: @statuses }
    end
  end

  # GET /statuses/1
  # GET /statuses/1.json
  def show
    @status = Status.find(params[:id])
    
    respond_to do |format|
      format.html #index.html.erb
      format.json { render json: @status }
  end
end
  # GET /statuses/new
  def new
    @status = current_user.statuses.new
    @status.build_document
    
    respond_to do |format|
      format.html #index.html.erb
      format.json { render json: @status }
    end
 end
  # GET /statuses/1/edit
  def edit
    @status = current_user.statuses.find(params[:id])
  end

  # POST /statuses
  # POST /statuses.json
  def create
    @status = current_user.statuses.new(params[:status])
    respond_to do |format|
      if @status.save
        current_user.create_activity(@status, 'created')
        format.html { redirect_to @status, notice: 'Status was successfully created.' }
        format.json { render json: @status, status: :created, location: @status }
      else
        format.html { render action: "new" }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /statuses/1
  # PATCH/PUT /statuses/1.json
  def update
    @status = current_user.statuses.find(params[:id])
    @document = @status.document
    
    @status.transaction do
      @status.update_attributes(params[:status])
      @document.update_attribute(params[:status][:document]) if @document
      current_user.create_activity(@status, 'updated')
      unless @status.valid? || (@status.valid? && @document && !document.valid?)
      raise ActiveRecord::Rollback
      end
    end
    
    respond_to do |format|
        format.html { redirect_to @status, notice: 'Status was successfully updated.' }
        format.json { head :no_context }
      end
    rescue ActiveRecord::Rollback
      respond_to do |format|
        format.html do
        flash.now[:error] = "Update failed"
         render action: "edit" 
       end
        format.json { render json: @status.errors, status: :unprocessable_entity }
    end
  end

  # DELETE /statuses/1
  # DELETE /statuses/1.json
  def destroy
    @status = current_user.statuses.find(params[:id])
     @status.destroy
     current_user.create_activity(@status, 'deleted')
    respond_to do |format|
      format.html { redirect_to statuses_url, notice: 'Status was successfully deleted.' }
      format.json { head :no_context }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_status
       @status = Status.find(params[:id])
      end

    # Never trust parameters from the scary internet, only allow the white list through.
    def status_params
      params.require(:status).permit(:name, :context, :user_id, :attachment, :avatar, :asset) 
    end
end
