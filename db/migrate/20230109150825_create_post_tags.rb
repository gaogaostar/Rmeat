class CreatePostTags < ActiveRecord::Migration[6.1]
  def change
    create_table :post_tags do |t|
      t.references :post_image, foreign_key: true
      t.references :tag, foreign_key: true
      t.timestamps
    end
  end
end
