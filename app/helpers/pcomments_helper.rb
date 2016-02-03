module PcommentsHelper
  def get_like_class(pcomment)
    if !current_user.nil? and current_user.voted_up_on? pcomment
      'color:blue'
    else
      'color:gray'
    end
  end

  def get_dislike_class(pcomment)
    if !current_user.nil? and current_user.voted_down_on? pcomment
      'color:red'
    else
      'color:gray'
    end
  end
end
