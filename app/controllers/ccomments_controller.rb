class CcommentsController < ApplicationController

  before_action only: [:show, :destroy]

  def show
  end

  def create
    @post = Post.find(params[:post_id])

    if @post.comments_disabled?
      redirect_to post_path(@post), alert: 'Comments not allowed here'
    else
      @pcomment = @post.pcomments.find(params[:pcomment_id])
      @ccomment = @pcomment.ccomments.build(post_params)
      @ccomment.approved = !@post.comments_approval?

      unless current_user.nil?
        @ccomment.user_id = current_user.id
        unless @ccomment.approved
          @ccomment.approved = (current_user == @post.user)
        end
      end

      approval = !@ccomment.approved ? ' waiting for approval' : ' saved'
      msg = @ccomment.save ? 'Ccomment' + approval : 'Unable to save Ccomment: ' + @ccomment.errors.full_messages.join('. ')
      redirect_to post_path(@post), notice: msg
    end
  end

  def destroy
    @post     = Post.find(params[:post_id])
    @pcomment = @post.pcomments.find(params[:pcomment_id])
    @ccomment = @pcomment.ccomments.find(params[:id])
    @ccomment.destroy
    redirect_to post_path(@post), :notice => 'Ccomment was deleted'
  end

  private

  def post_params
    params.require(:ccomment).permit(:post_id, :pcomment_id, :name, :message)
  end

end
