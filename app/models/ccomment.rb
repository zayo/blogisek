class Ccomment < ActiveRecord::Base
  belongs_to :user
  belongs_to :pcomment

  validates_presence_of :pcomment, :name, :message

end
