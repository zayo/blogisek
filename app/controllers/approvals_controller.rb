class ApprovalsController < ApplicationController

  before_action only: [:index, :update]

  # GET /approvals
  def index
    if !current_user.nil?
      @pcomments = Pcomment.joins(:post).where('posts.user_id = ?', current_user.id).where('approved = ?', false)

      @ccomments = Ccomment.where('pcomment_id IN (?)', Pcomment.joins(:post).where('posts.user_id = ?', current_user.id).map(&:id)).where('approved = ?', false)
    end
  end

  def update
    # code here

    pp params

  end


  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:user_id, :title, :description, :is_private, :options)
  end
end
