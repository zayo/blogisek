module CcommentsHelper
  def get_like_class(ccomment)
    if !current_user.nil? and current_user.voted_up_on? ccomment
      'color:blue'
    else
      'color:gray'
    end
  end

  def get_dislike_class(ccomment)
    if !current_user.nil? and current_user.voted_down_on? ccomment
      'color:red'
    else
      'color:gray'
    end
  end
end
