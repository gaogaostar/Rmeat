class Public::PostImagesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]


  def new
    @post_image = PostImage.new
  end

  def create
    @post_image = PostImage.new(post_image_params)
    @post_image.user_id = current_user.id
    if @post_image.save
      redirect_to post_images_path
    else
      render :new
    end
  end

  def index
    @post_images = PostImage.all
  end

  def show
    @post_image = PostImage.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
  end

  def update
  end

  def destroy
    @post_image = PostImage.find(params[:id])
    @post_image.destroy
    redirect_to post_images_path
  end


  private

  def post_image_params
    params.require(:post_image).permit(:image, :shop_name, :shop_location, :star, :price, :title, :body)
  end

  # before_actionのメソッド：投稿したユーザーのみが編集・削除できる
  def ensure_correct_user
    @post_image = PostImage.find(params[:id])
    unless @post_image.user == current_user
      redirect_to post_images_path
    end
  end

end
