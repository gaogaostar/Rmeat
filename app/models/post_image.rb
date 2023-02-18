class PostImage < ApplicationRecord
  has_one_attached :image

  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  validates :image, presence: true
  validates :title, presence: true
  validates :star, presence: true
  validates :shop_name, presence: true
  validates :shop_location, presence: true
  validates :lat, presence: true
  validates :lng, presence: true

  # 画像がない場合に表示する画像を用意
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path),filename: 'default-image,jpg', content_type:'image/jpeg')
    end
    image
  end

  # 一覧画面で★を表示するためのメソッド
  def star_percentage
    star.round(1).to_f*100/5
  end

  # キーワード検索用のメソッド
  def self.search(search)
    if search != ""
      PostImage.where(['title LIKE(?) OR body LIKE(?) OR shop_name LIKE(?)', "%#{search}%", "%#{search}%", "%#{search}%"])
    else
      PostImage.includes(:user).order('created_at DESC')
    end
  end

end
