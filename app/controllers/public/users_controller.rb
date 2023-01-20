class Public::UsersController < ApplicationController
  before_action :admin_user, only: [:index, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def edit
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "ユーザーを削除しました"
    redirect_to :users_path
  end

  private

  def admin_user
    redirect_to post_images_path unless current_user.admin?
  end

end
