class PostCommentsController < ApplicationController

  before_action only: [:show, :destroy]

  def show
  end

  def new
    @post = Post.find(params[:post_id])
    @post_comment         = @post.post_comments.build
  end

  def create
    @post = Post.find(params[:post_id])
    @post_comment         = @post.post_comments.build(post_params)

    if not current_user.nil?
      @comment.user_id = current_user.id
    end

    if @post_comment.save
      #redirect_to post_path @post, notice: 'Post comment was successfully created.'
    else
      #render :new
    end
  end

  def destroy
  end

  private

  def post_params
    params.require(:post_comment).permit(:name, :message)
  end
end
