class SudachiImagesController < ApplicationController
  before_action :set_sudachi_image, only: [:destroy]

  # GET /sudachi_images
  # GET /sudachi_images.json
  def index
    @sudachi_images = SudachiImage.all
    @sudachi_images.each do |sudachi_image|
      pp sudachi_image.image.url
      pp sudachi_image.image.thumb.url
    end
  end

  # GET /sudachi_images/1
  # GET /sudachi_images/1.json

  # GET /sudachi_images/new
  def new
    @sudachi_image = SudachiImage.new
  end

  # POST /sudachi_images
  # POST /sudachi_images.json
  def create
    @sudachi_image = SudachiImage.new(sudachi_image_params)

    respond_to do |format|
      if @sudachi_image.save
        format.html {redirect_to sudachi_images_path, notice: 'Sudachi image was successfully created.'}
        format.json {render :index, status: :created, location: @sudachi_image}
      else
        format.html {render :new}
        format.json {render json: @sudachi_image.errors, status: :unprocessable_entity}
      end
    end
  end


  # DELETE /sudachi_images/1
  # DELETE /sudachi_images/1.json
  def destroy
    @sudachi_image.destroy
    respond_to do |format|
      format.html {redirect_to sudachi_images_url, notice: 'Sudachi image was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_sudachi_image
    @sudachi_image = SudachiImage.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def sudachi_image_params
    params.require(:sudachi_image).permit(:image)
  end
end
