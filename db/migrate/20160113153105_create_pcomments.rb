class CreatePcomments < ActiveRecord::Migration
  def change
    create_table :pcomments do |t|
      t.string :name
      t.text :message
      t.references :user, index: true, foreign_key: true
      t.references :post, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
