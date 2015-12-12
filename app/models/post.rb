class Post < ActiveRecord::Base
  resourcify
  belongs_to :user

  def user_name
    self.user.email
  end
end
