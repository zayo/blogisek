class PostsController < ApplicationController

  before_action only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    #@available_tags = Tag.select('tags.*, count(posts_tags.tag_id) AS count').joins(:posts_tags).group('tags.id').order('count DESC')
    @available_tags = Tag.select('tags.*, count(pt.tag_id) AS cnt').joins('JOIN posts_tags pt ON tags.id = pt.tag_id').group('tags.id').order('cnt DESC')

    if !current_user.nil?
      if params[:tag]
        @posts = Post.tagged_with(params[:tag]).eager_load(:tags, :user).order('posts.updated_at DESC')
      else
        @posts = Post.eager_load(:tags, :user).order('posts.updated_at DESC')
      end
    else
      if params[:tag]
        @posts = Post.where('is_private <> ?', true).tagged_with(params[:tag]).eager_load(:tags, :user).order('posts.updated_at DESC')
      else
        @posts = Post.where('is_private <> ?', true).eager_load(:tags, :user).order('posts.updated_at DESC')
      end
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.where('posts.id = ?', params[:id]).eager_load(:user, :pcomments).first
  rescue ActiveRecord::RecordNotFound
    @post = {}
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post         = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    new_params           = post_params
    new_params[:user_id] = @post.user_id
    if @post.update(new_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
    update_tags
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
    update_tags
  end

  private

  def update_tags
    Tag.where('tags.id NOT IN (SELECT DISTINCT tag_id FROM posts_tags)').destroy_all
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    @post = {}
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:user_id, :title, :description, :is_private, :options, :all_tags)
  end
end
