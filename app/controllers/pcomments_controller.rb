class PcommentsController < ApplicationController

  before_action only: [:show, :destroy]

  def show
  end

  def create
    @post     = Post.find(params[:post_id])
    @pcomment = @post.pcomments.build(post_params)

    if not current_user.nil?
      @pcomment.user_id = current_user.id
    end

    msg = @pcomment.save ? 'Post comment saved' : 'Unable to save post comment: ' + @pcomment.errors.full_messages.join('. ')
    redirect_to post_path(@post), notice: msg
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
