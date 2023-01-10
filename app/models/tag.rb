class Tag < ApplicationRecord

  has_many :post_tsgs, dependent: :destroy

end
