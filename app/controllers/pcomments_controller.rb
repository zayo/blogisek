class CommentsController < ApplicationController

  before_action :set_post, only: [:create, :destroy]
  before_action :set_comment, only: [:destroy, :approve, :disapprove, :like, :dislike]

  respond_to :html

  def create
    if @post.comments_disabled?
      redirect_to post_path(@post), alert: 'Comments not allowed here'
    else
      @pcomment          = @post.pcomments.build(post_params)
      @pcomment.approved = !@post.comments_approval?

      unless current_user.nil?
        @pcomment.user_id = current_user.id
        unless @pcomment.approved
          @pcomment.approved = (current_user == @post.user)
        end
      end

      approval = !@pcomment.approved ? ' waiting for approval' : ' saved'
      msg      = @pcomment.save ? 'Comment' + approval : 'Unable to save comment: ' + @pcomment.errors.full_messages.join('. ')
      redirect_to post_path(@post), notice: msg
    end
  end

  def approve
    @pcomment.approved = true
    @pcomment.save
    redirect_to :back, :notice => 'Comment was approved'
  end

  def disapprove
    @pcomment.destroy
    redirect_to :back, :notice => 'Comment was deleted'
  end

  def like
    unless current_user.nil?
      current_user.likes @pcomment
      redirect_to :back, :notice => 'Comment was liked'
    end
  end

  def dislike
    unless current_user.nil?
      current_user.dislikes @pcomment
      redirect_to :back, :notice => 'Comment was disliked'
    end
  end


  def destroy
    @pcomment = @post.pcomments.find(params[:id])
    @pcomment.destroy
    redirect_to post_path(@post), :notice => 'Comment was deleted'
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @pcomment = Comment.find(params[:id])
  end

  def post_params
    params.require(:pcomment).permit(:post_id, :name, :message)
  end
end
