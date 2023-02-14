class Public::UsersController < ApplicationController
  before_action :admin_user, only: [:index, :destroy]

  def index
    @users = User.all
  end

  def show
    @user = current_user
    @post_images = @user.post_images
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "会員情報を更新しました"
      redirect_to my_page_path
    else
      render "edit"
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "ユーザーを削除しました"
    redirect_to users_path
  end


  private

  def admin_user
    redirect_to post_images_path unless current_user.admin?
  end

end
