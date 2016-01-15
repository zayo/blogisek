class Post < ActiveRecord::Base
  resourcify

  belongs_to :user
  has_and_belongs_to_many :tags
  has_many :pcomments, :dependent => :destroy
  has_many :ccomments

  accepts_nested_attributes_for :pcomments

  enum options: { comments_allowed: 0, comments_approval: 1, comments_disabled: 2 }

  def user_name
    self.user.email
  end
end
