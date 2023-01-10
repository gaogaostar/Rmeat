class PostImage < ApplicationRecord
  has_one_attached :image

  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy

  validates :shop_name, presence: true
  validates :image, presence: true

end
