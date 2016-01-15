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

  def self.tagged_with(name)
    Tag.find_by_name!(name).posts
  end

  def all_tags=(names)
    self.tags = names.split(/[\s,]+/).uniq.map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  def all_tags
    tags.map(&:name).join(", ")
  end

  def destroy
    super
    Tag.where('tags.id NOT IN (SELECT DISTINCT tag_id FROM posts_tags)').destroy_all
  end
end
