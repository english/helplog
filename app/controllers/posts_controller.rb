class PostsController < ApplicationController
  respond_to :json
  before_action :authenticate, only: %i( create update destroy )

  def index
    respond_with Post.all
  end

  def show
    respond_with Post.find(params[:id])
  end

  def create
    respond_with Post.create(post_params)
  end

  def update
    respond_with Post.update(params[:id], post_params)
  end

  def destroy
    respond_with Post.destroy(params[:id])
  end

  def edit
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :published)
  end

  def authenticate
    render json: { errors: 'forbidden' }, status: :forbidden unless logged_in?
  end
end
