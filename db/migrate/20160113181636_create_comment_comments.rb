class CreateCommentComments < ActiveRecord::Migration
  def change
    create_table :comment_comments do |t|
      t.string :name
      t.text :message
      t.integer :likes
      t.integer :dislikes
      t.references :user, index: true, foreign_key: true
      t.references :post_comment, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
