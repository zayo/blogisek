class Post < ActiveRecord::Base
  resourcify
  belongs_to :user
  has_and_belongs_to_many :tags
  has_many :post_comments, :dependent => :destroy

  accepts_nested_attributes_for :post_comments

  def user_name
    self.user.email
  end
end
