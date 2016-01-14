class CcommentsController < ApplicationController

  before_action only: [:show, :destroy]

  def show
  end

  def create
    @post            = Post.find(params[:post_id])
    @pcomment    = @post.pcomments.find(params[:comment_id])
    @ccomment = @pcomment.ccomments.build(post_params)

    if not current_user.nil?
      @ccomment.user_id = current_user.id
    end

    msg = @ccomment.save ? 'Post comment saved' : 'Unable to save post comment: ' + @ccomment.errors.full_messages.join('. ')
    redirect_to post_path(@post), notice: msg
  end

  def destroy
    @post            = Post.find(params[:post_id])
    @pcomment    = @post.pcomments.find(params[:comment_id])
    @ccomment = @pcomment.ccomments.find(params[:id])
    @ccomment.destroy
    redirect_to post_path(@post), :notice => 'Ccomment was deleted'
  end

  private

  def post_params
    params.require(:ccomment).permit(:comment_id, :name, :message)
  end

end
