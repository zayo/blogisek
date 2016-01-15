class PcommentsController < ApplicationController

  before_action only: [:create, :destroy, :approve, :disapprove, :like, :dislike]

  def create
    @post = Post.find(params[:post_id])

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
      msg      = @pcomment.save ? 'Pcomment' + approval : 'Unable to save pcomment: ' + @pcomment.errors.full_messages.join('. ')
      redirect_to post_path(@post), notice: msg
    end
  end

  def approve
    #user approves comment
    @comment          = Pcomment.find(params[:id])
    @comment.approved = true
    @comment.save
    redirect_to :back, :notice => 'Pcomment was approved'
  end

  def disapprove
    @pcomment = Pcomment.find(params[:id])
    @pcomment.destroy
    redirect_to :back, :notice => 'Pcomment was deleted'
  end

  def like
    @comment = Pcomment.find(params[:id])
    @comment.likes += 1
    @comment.save
    redirect_to :back, :notice => 'Pcoment was liked'
  end

  def dislike
    @comment = Pcomment.find(params[:id])
    @comment.dislikes += 1
    @comment.save
    redirect_to :back, :notice => 'Pcoment was disliked'
  end


  def destroy
    @post     = Post.find(params[:post_id])
    @pcomment = @post.pcomments.find(params[:id])
    @pcomment.destroy
    redirect_to post_path(@post), :notice => 'Pcomment was deleted'
  end

  private

  def post_params
    params.require(:pcomment).permit(:post_id, :name, :message)
  end
end
