class GalleriesController < ApplicationController
  before_action :set_gallery, only: [:show, :edit, :update, :destroy]
  # config.middleware.insert_before Rack::Runtime, "InvalidPostDataInterceptor"
  skip_before_filter :verify_authenticity_token  
  # GET /galleries
  # GET /galleries.json
  def index
    @galleries = Gallery.all
    @gallery = Gallery.new
  end

  def addFavorite
    photo_id = params["image"]
    print(photo_id)
    current_user.galleries << Gallery.find(photo_id)
  end
  
  def addPhoto
    print("~~~~~~~~~" + params["image"] + " THAT WAS THE PHOTO \n")
    photo = params["image"]
    print("~~~~~~~~~~~ photo type: " + photo.class.to_s + "\n")
    gallery = Gallery.new
    gallery.image = ImageUploader(photo)
    gallery.save!
    print("~~~~~~~~~~ url: " + gallery.image.url.to_s + "\n")
    print("~~~~~~~~~~ path: " + gallery.image.current_path.to_s + "\n")
    print("~~~~~~~~~~ image identifier: " + gallery.image_identifier.to_s + "\n")
    Gallery.columns_hash.each {|k,v| puts "#{k} => #{v.type}"}
    # gallery = Gallery.new()
    # @galery.image = photo
    # @galery.save
    # params.keys.each do |key|
    #   print("~~~~~~" + key.to_s)
    # end
    # File.open("photo", 'wb') do |f|
    #   f.write photo
    #   @gallery = Gallery.new(photo)
    #   @gallery.save
    # end
    # @gallery = Gallery.new(photo)
    # @gallery.save
    # render json: @gallery
    # print(params.keys)
    # File.open('somewhere') do |f|
    #   u.avatar = f
    # end
    # print("~~~~~~~~~~" + photo.to_s)
    # current_user.galleries << Gallery.find(photo_id)
  end
  
  # GET /galleries/1
  # GET /galleries/1.json
  def show
  end

  # GET /galleries/new
  def new
    @gallery = Gallery.new
  end

  # GET /galleries/1/edit
  def edit
  end

  # POST /galleries
  # POST /galleries.json
  def create
    @gallery = Gallery.new(gallery_params)
    @gallery.save
    redirect_to galleries_path
    # respond_to do |format|
    #   if @gallery.save
    #     format.html { redirect_to galleries_path, notice: 'Gallery was successfully created.' }
    #     # format.json { render :show, status: :created, location: @gallery }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @gallery.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /galleries/1
  # PATCH/PUT /galleries/1.json
  def update
    respond_to do |format|
      if @gallery.update(gallery_params)
        format.html { redirect_to @gallery, notice: 'Gallery was successfully updated.' }
        format.json { render :show, status: :ok, location: @gallery }
      else
        format.html { render :edit }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /galleries/1
  # DELETE /galleries/1.json
  def destroy
    @gallery.destroy
    respond_to do |format|
      format.html { redirect_to galleries_url, notice: 'Gallery was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gallery
      @gallery = Gallery.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gallery_params
      params.require(:gallery).permit(:name, :description, :image)
    end
    
end
