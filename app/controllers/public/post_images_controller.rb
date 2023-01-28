class Public::PostImagesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search_tag]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def new
    @post_image = PostImage.new
  end

  def create
    @post_image = PostImage.new(post_image_params)
    @post_image.user_id = current_user.id
    params[:post_image][:tag] ? @post_image.tag = params[:post_image][:tag].join(",") : false
    tag_list = params[:post_image][:tag_name].split(',')

    if @post_image.save
      @post_image.save_tag(tag_list)
      redirect_to post_image_path(@post_image), notice:"投稿しました"
    else
      render :new
    end
  end

  def index
    @post_images = PostImage.all.order(id: "DESC")
    @tag_list = Tag.all
  end

  def show
    @post_image = PostImage.find(params[:id])
    @post_comment = PostComment.new
    @post_tags = @post_image.tags
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

  def search_tag
    #検索結果画面でもタグ一覧表示
    @tag_list = Tag.all
    #検索されたタグを受け取る
    @tag = Tag.find(params[:tag_id])
    #検索されたタグに紐づく投稿を表示
    @post_images = @tag.post_images.all  # .page(params[:page]).per(10)
  end

  def search_keyword
    # キーワードが入力されていないと投稿一覧に飛ぶ
    redirect_to post_images_path if params[:keyword] == ""
    # 空白で分割
    @keywords = params[:keyword].split(/[[:blank:]]+/).select(&:present?)
    # 分割したキーワードごとに検索
    @keywords.each do |keyword|
      # 部分一致で検索
      @post_images = PostImage.where(["title LIKE(?) OR body LIKE(?) OR shop_name LIKE(?) OR shop_location LIKE(?)", "%#{params[:keyword]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%"])
    end
    @tag_list = Tag.all
  end


  private

  # before_action:投稿したユーザーのみが編集・削除できる
  def ensure_correct_user
    @post_image = PostImage.find(params[:id])
    unless (@post_image.user == current_user) || current_user&.admin?
      redirect_to post_images_path
    end
  end

  # # before_action:管理者かどうか確認
  # def admin_user
  #   redirect_to root_path unless current_user.admin?
  # end

  def post_image_params
    params.require(:post_image).permit(:image, :shop_name, :shop_location, :lat, :lng, :star, :title, :body, :keyword, tag_ids:[])
  end

end
