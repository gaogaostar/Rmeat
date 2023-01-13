class PostTag < ApplicationRecord

  belongs_to :post_image
  belongs_to :tag

  validates :post_image_id, presence: true
  validates :tag_id, presence: true
end
