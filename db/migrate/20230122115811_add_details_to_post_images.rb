class AddDetailsToPostImages < ActiveRecord::Migration[6.1]
  def change
    add_column :post_images, :lat, :float
    add_column :post_images, :lng, :float
  end
end
