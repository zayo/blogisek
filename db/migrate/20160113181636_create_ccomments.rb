class CreateCcomments < ActiveRecord::Migration
  def change
    create_table :ccomments do |t|
      t.string :name
      t.text :message
      t.integer :likes, :default => 0
      t.integer :dislikes, :default => 0
      t.references :user, index: true, foreign_key: true
      t.references :pcomment, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end