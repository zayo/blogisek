module PostsHelper
  def tag_links(tags)
    tags.split(",").map { |tag| link_to tag.strip, tag_path(tag.strip), class: 'post-tags' }.join(", ")
  end

  def all_tag_links(tags)
    tags.map { |tag| link_to tag.name.strip, tag_path(tag.name.strip), class: 'filter-by-tag' }.join(", ")
  end
end
