class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_filter :find_user
  before_filter :find_album
  before_filter :find_picture, only: [:edit, :update, :show, :destroy]
  before_filter :ensure_proper_user, only: [:edit, :new, :create, :update, :destroy]
  before_filter :add_breadcrumbs

  # GET /pictures
  # GET /pictures.json
  def index
    @pictures = @album.pictures.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pictures}
    end
  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show
    add_breadcrumb @picture, album_picture_path(@album, @picture)
        
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @picture }
    end
  end

  # GET /pictures/new
  def new
    @picture = @album.pictures.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @picture }
    end
  end

  # GET /pictures/1/edit
  def edit
   add_breadcrumb @picture, album_picture_path(@album, @picture)
   add_breadcrumb "Editing Picture"
  end

  # POST /pictures
  # POST /pictures.json
  def create
    @picture = @album.pictures.new(params[:picture])
    @picture.user = current_user

    respond_to do |format|
      if @picture.save
        current_user.create_activity @picture, 'created'
        format.html { redirect_to album_pictures_path(@album), notice: 'Picture was successfully created.' }
        format.json { render json: @picture, status: :created, location: @picture }
      else
        format.html { render action: 'new' }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pictures/1
  # PATCH/PUT /pictures/1.json
  def update    
    respond_to do |format|
      if @picture.update_attributes(params[:picture])
        current_user.create_activity @picture, 'updated'
        format.html { redirect_to album_pictures_path(@album), notice: 'Picture was successfully updated.' }
        format.json { head :no_context }
      else
        format.html { render action: "edit" }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @picture.destroy
    
    respond_to do |format|
      current_user.create_activity @picture, 'deleted'
      format.html { redirect_to album_pictures_url(@album), notice: 'Picture was successfully destroyed.' }
      format.json { head :no_context }
    end
  end
  
  def url_options
    { profile_name: params[:profile_name] }.merge(super)
  end

  private
   def ensure_proper_user
     if current_user != @user
       flash[:error] = "You don't have permission to do that."
       redirect_to album_pictures_path
     end
   end
   
  def add_breadcrumbs
    add_breadcrumb @user.first_name, profile_path(@user)
    add_breadcrumb "Albums", albums_path(@user)
    add_breadcrumb "Pictures", album_pictures_path(@album)
  end
  
  # Use callbacks to share common setup or constraints between actions.
    def set_picture
      @picture = Picture.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def picture_params
      params.require(:picture).permit(:album_id, :user_id, :caption, :description)
    end
  
  def find_user
    @user = User.find_by_profile_name(params[:profile_name])
  end
  
  def find_album
    if signed_in? && current_user.profile_name == params[:profile_name]
      @album = current_user.albums.find(params[:album_id])
    else
      @album = @user.albums.find(params[:album_id])
    end
  end
  
  def find_picture
    @picture = @album.pictures.find(params[:id])
  end
end
