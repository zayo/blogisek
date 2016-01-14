class CommentCommentsController < ApplicationController

  before_action only: [:show, :destroy]

  def show
  end

  def create
    @post            = Post.find(params[:post_id])
    @post_comment    = @post.post_comments.find(params[:comment_id])
    @comment_comment = @post_comment.comment_comments.build(post_params)

    if not current_user.nil?
      @comment_comment.user_id = current_user.id
    end

    msg = @comment_comment.save ? 'Post comment saved' : 'Unable to save post comment: ' + @comment_comment.errors.full_messages.join('. ')
    redirect_to post_path(@post), notice: msg
  end

  def destroy
    @post            = Post.find(params[:post_id])
    @post_comment    = @post.post_comments.find(params[:comment_id])
    @comment_comment = @post_comment.comment_comments.find(params[:id])
    @comment_comment.destroy
    redirect_to post_path(@post), :notice => 'Comment comment was deleted'
  end

  private

  def post_params
    params.require(:comment_comment).permit(:comment_id, :name, :message)
  end

end
