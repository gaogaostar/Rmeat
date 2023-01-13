class Tag < ApplicationRecord

  has_many :post_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :post_images, through: :post_tags

  validates :tag_name, uniqueness: true

end
