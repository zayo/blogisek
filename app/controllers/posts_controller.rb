class PostsController < ApplicationController

  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :all_posts, only: [:index]
  after_action :update_tags, only: [:update, :destroy]

  respond_to :html


  def new
    @post = Post.new
  end

  def create
    @post         = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def update
    new_params           = post_params
    new_params[:user_id] = @post.user_id
    if @post.update(new_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  private

  def update_tags
    Tag.where('tags.id NOT IN (SELECT DISTINCT tag_id FROM posts_tags)').destroy_all
  end

  def all_posts
    @available_tags = Tag.select('tags.*, count(pt.tag_id) AS cnt').joins('JOIN posts_tags pt ON tags.id = pt.tag_id').group('tags.id').order('cnt DESC')

    if !current_user.nil? and params[:tag]
      @posts = Post.tagged_with(params[:tag])
                 .eager_load(:tags, :user)
                 .order('posts.updated_at DESC')
    elsif !current_user.nil?
      @posts = Post.eager_load(:tags, :user)
                 .order('posts.updated_at DESC')
    elsif params[:tag]
      @posts = Post.where('posts.is_private = ?', false)
                 .tagged_with(params[:tag])
                 .eager_load(:tags, :user)
                 .order('posts.updated_at DESC')
    else
      @posts = Post.where('posts.is_private = ?', false)
                 .eager_load(:tags, :user)
                 .order('posts.updated_at DESC')
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.where('posts.id = ?', params[:id]).eager_load(:user, :pcomments).first
  rescue ActiveRecord::RecordNotFound
    @post = {}
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:user_id, :title, :description, :is_private, :options, :all_tags)
  end
end
