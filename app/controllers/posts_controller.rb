class PostsController < ApplicationController
  before_action :set_post, only: %i( show edit update destroy )
  before_action -> { redirect_to login_path unless logged_in? }, except: %w( show published )

  def index
    @posts = Post.all
    fresh_when(etag: @posts, last_modified: @posts.maximum(:updated_at), public: true)
  end

  def show
    fresh_when(@post)
    render status: :forbidden unless logged_in? or @post.published?
  end

  def new
    @post = Post.new
  end

  def edit
    fresh_when(@post)
  end

  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render action: 'show', status: :created, location: @post }
      else
        format.html { render action: 'new' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  def unpublished
    @posts = Post.unpublished
    fresh_when(etag: @posts, last_modified: @posts.maximum(:updated_at))
  end

  def published
    @posts = Post.published
    fresh_when(etag: @posts, last_modified: @posts.maximum(:updated_at), public: true)
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :published)
  end
end
