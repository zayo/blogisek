module CcommentsHelper
  def get_like_class(ccomment)
    if !current_user.nil? and current_user.voted_as_when_voted_for ccomment
      'btn btn-info btn-xs'
    else
      'btn btn-default btn-xs'
    end
  end

  def get_dislike_class(ccomment)
    if !current_user.nil? and !current_user.voted_as_when_voted_for ccomment
      'btn btn-info btn-xs'
    else
      'btn btn-default btn-xs'
    end
  end
end
