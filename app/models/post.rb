class Post < ActiveRecord::Base
  resourcify
  belongs_to :user
  has_and_belongs_to_many :tags

  def user_name
    self.user.email
  end
end
