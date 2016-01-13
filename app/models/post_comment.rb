class PostComment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  has_many :comment_comments

  accepts_nested_attributes_for :comment_comments

  validates_presence_of :post, :name, :message
end
