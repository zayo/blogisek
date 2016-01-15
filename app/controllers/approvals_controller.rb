class ApprovalsController < ApplicationController

  before_action only: [:index]

  # GET /approvals
  def index
    if !current_user.nil?
      @pcomments = Pcomment.joins(:post).where('posts.user_id = ?', current_user.id).where('approved = ?', false)
      @ccomments = Ccomment.joins(:post).where('posts.user_id = ?', current_user.id).where('approved = ?', false)
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:user_id, :title, :description, :is_private, :options)
  end
end
