class CreatePostComments < ActiveRecord::Migration
  def change
    create_table :post_comments do |t|
      t.string :name
      t.text :message
      t.integer :likes
      t.integer :dislikes
      t.references :user, index: true, foreign_key: true
      t.references :post, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
