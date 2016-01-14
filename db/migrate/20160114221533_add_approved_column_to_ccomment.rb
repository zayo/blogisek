class AddApprovedColumnToCcomment < ActiveRecord::Migration
  def change
    add_column :ccomments, :approved, :boolean, :default => true
  end
end
