class Admin::PostImagesController < ApplicationController

  def index
    @post_images = PostImage.all.order(id: "DESC")
  end

  def show
  end

  def destroy
    post_image = PostImage.find(params[:id])
    post_image.destroy
    redirect_to admin_post_images_path
  end

end
