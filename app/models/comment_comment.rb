class CommentComment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post_comment

  validates_presence_of :post_comment, :name, :message

end
