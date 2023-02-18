class Public::UsersController < ApplicationController
  before_action :admin_user, only: [:index, :destroy]
  before_action :ensure_guest_user, only: [:edit]

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
      flash[:notice] = "ユーザー情報を更新しました"
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

  def ensure_guest_user
    @user = current_user
    if @user.name == "ゲストユーザー"
      redirect_to my_page_path(current_user), notice:'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
