class PostCommentsController < ApplicationController

  before_action only: [:show, :destroy]

  def show
  end

  def create
    @post         = Post.find(params[:post_id])
    @post_comment = @post.post_comments.build(post_params)

    if not current_user.nil?
      @post_comment.user_id = current_user.id
    end

    msg = @post_comment.save ? 'Post comment saved' : 'Unable to save post comment: ' + @post_comment.errors.full_messages.join('. ')
    redirect_to post_path(@post), notice: msg
  end

  def destroy
    @post         = Post.find(params[:post_id])
    @post_comment = @post.post_comments.find(params[:id])
    @post_comment.destroy
    redirect_to post_path(@post), :notice => 'Post comment was deleted'
  end

  private

  def post_params
    params.require(:post_comment).permit(:post_id, :name, :message)
  end
end
