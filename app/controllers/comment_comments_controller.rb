class CommentCommentsController < ApplicationController

  def show
  end

  def new
    @comment_comment = CommentComment.new
  end

  def destroy
  end
end
