class CreatePostImages < ActiveRecord::Migration[6.1]
  def change
    create_table :post_images do |t|
      t.integer :user_id, null: false
      t.string :shop_name, null: false
      t.string :shop_location, null: false
      t.integer :star, null: false
      # t.integer :price, null: false
      t.string :title, null: false
      t.text :body, null: false

      t.timestamps
    end
  end
end
