module PcommentsHelper
  def get_like_class(pcomment)
    if !current_user.nil? and current_user.voted_as_when_voted_for pcomment
      'btn btn-info btn-xs'
    else
      'btn btn-default btn-xs'
    end
  end

  def get_dislike_class(pcomment)
    if !current_user.nil? and !current_user.voted_as_when_voted_for pcomment
      'btn btn-info btn-xs'
    else
      'btn btn-default btn-xs'
    end
  end
end
