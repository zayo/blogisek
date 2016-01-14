class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name, unique: true
      t.integer :karma

      t.timestamps null: false
    end
  end
end 
