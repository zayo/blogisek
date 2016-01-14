class Pcomment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  has_many :ccomments, -> { where approved: true }, :dependent => :destroy

  accepts_nested_attributes_for :ccomments

  validates_presence_of :post, :name, :message
end
