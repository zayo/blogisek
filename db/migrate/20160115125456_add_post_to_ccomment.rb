class AddPostToCcomment < ActiveRecord::Migration
  def change
    add_reference :ccomments, :post, index: true, foreign_key: true
  end
end
