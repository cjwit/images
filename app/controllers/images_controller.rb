class ImagesController < ApplicationController
  def index
    @images = Image.all
  end

  def new
    @image = Image.new
  end

  def create
    @image = Image.create!(image_params)
    @image.imageFile.attach(params[:image][:imageFile])

    if @image.save
      redirect_to '/'
    else
      render :new
    end
  end

  private
    def image_params
      params.require(:image).permit(:title, :imageFile)
    end
end
