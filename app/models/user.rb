class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/image-missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  has_many :posts, :dependent => :destroy
  has_many :pcomments, :dependent => :destroy
  has_many :ccomments, :dependent => :destroy

  validates :user_name, presence: true, length: { minimum: 4, maximum: 56 }

  accepts_nested_attributes_for :posts
end
