class CcommentsController < ApplicationController

  before_action :set_post, only: [:create, :destroy]
  before_action :set_comment, only: [:destroy, :approve, :disapprove, :like, :dislike]

  def create
    if @post.comments_disabled?
      redirect_to post_path(@post), alert: 'Comments not allowed here'
    else
      @pcomment          = @post.pcomments.find(params[:pcomment_id])
      @ccomment          = @pcomment.ccomments.build(post_params)
      @ccomment.post_id  = @post.id
      @ccomment.approved = !@post.comments_approval?

      unless current_user.nil?
        @ccomment.user_id  = current_user.id
        @ccomment.approved = @ccomment.approved ? true : (current_user == @post.user)
      end

      approval = !@ccomment.approved ? ' waiting for approval' : ' saved'
      msg      = @ccomment.save ? 'Ccomment' + approval : 'Unable to save Ccomment: ' + @ccomment.errors.full_messages.join('. ')
      redirect_to post_path(@post), notice: msg
    end
  end

  def approve
    #user approves comment
    @ccomment.approved = true
    @ccomment.save
    redirect_to :back, :notice => 'Ccomment was approved'
  end

  def disapprove
    @ccomment.destroy
    redirect_to :back, :notice => 'Ccomment was deleted'
  end

  def like
    unless current_user.nil?
      current_user.likes @ccomment
      redirect_to :back, :notice => 'Ccoment was liked'
    end
  end

  def dislike
    unless current_user.nil?
      current_user.dislikes @ccomment
      redirect_to :back, :notice => 'Ccoment was disliked'
    end
  end

  def destroy
    @pcomment = @post.pcomments.find(params[:pcomment_id])
    @ccomment = @pcomment.ccomments.find(params[:id])
    @ccomment.destroy
    redirect_to post_path(@post), :notice => 'Ccomment was deleted'
  end

  private
  def set_comment
    @ccomment = Ccomment.find(params[:id])
  end

  private
  def set_post
    @post = Post.find(params[:post_id])
  end

  private

  def post_params
    params.require(:ccomment).permit(:post_id, :pcomment_id, :name, :message)
  end
end