class AddTypeRefColumnToPost < ActiveRecord::Migration
  def change
    add_column :posts, :options, :integer, :default => 0
  end
end
