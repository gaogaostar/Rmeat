class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image

  has_many :post_images, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  validates :name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :email, presence: true, uniqueness: true
  # validates :introduction, length: { maximum: 200 }

  # プロフィール画像についてのメソッド
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/user_no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename:'default-image.jpg', content_type:'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  # users/sessions_controller.rbで記述したUser.guestのguestメソッド
  def self.guest
    find_or_create_by!(name: 'guestuser' ,email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end
end
