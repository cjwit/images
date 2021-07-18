class ImagesController < ApplicationController
  def index
    @images = Image.all
  end

  def new
    @image = Image.new
  end

  def create
    @image = Image.new(image_params)
    if @image.save
      redirect_to '/'
    else
      render :new
    end
  end

  private
    def image_params
      params.require(:image).permit(:title, :file)
    end
end
