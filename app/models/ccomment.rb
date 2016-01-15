class Ccomment < ActiveRecord::Base
  acts_as_votable

  belongs_to :user
  belongs_to :pcomment
  belongs_to :post

  validates_presence_of :pcomment, :name, :message

end
