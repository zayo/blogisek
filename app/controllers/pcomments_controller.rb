class PcommentsController < ApplicationController

  before_action only: [:show, :update, :destroy]

  def show
  end

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

  def update
    #user approves comment
    @comment          = Pcomment.find(params[:id])
    @comment.approved = true
    @comment.save
    redirect_to approvals_path, :notice => 'Pcomment was approved'
  end

  def destroy
    if params[:post_id]
      @post     = Post.find(params[:post_id])
      @pcomment = @post.pcomments.find(params[:id])
      @pcomment.destroy
      redirect_to post_path(@post), :notice => 'Pcomment was deleted'
    else
      @pcomment = Pcomment.find(params[:id])
      @pcomment.destroy
      redirect_to approvals_path, :notice => 'Pcomment was deleted'
    end
  end

  private

  def post_params
    params.require(:pcomment).permit(:post_id, :name, :message)
  end
end
