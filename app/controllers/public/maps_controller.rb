class Public::MapsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post_images = PostImage.all
  end

end
