class Pcomment < ActiveRecord::Base
  acts_as_votable

  belongs_to :user
  belongs_to :post
  has_many :ccomments, :dependent => :destroy

  accepts_nested_attributes_for :ccomments

  validates_presence_of :post, :name, :message
end
