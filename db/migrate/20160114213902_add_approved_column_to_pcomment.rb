class AddApprovedColumnToPcomment < ActiveRecord::Migration
  def change
    add_column :pcomments, :approved, :boolean, :default => true
  end
end
