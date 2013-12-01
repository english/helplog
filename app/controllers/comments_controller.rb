class CommentsController < ApplicationController
  respond_to :json
  before_action :authenticate, only: :destroy

  def index
    respond_with Comment.all
  end

  def create
    post = Post.find(comment_params[:post_id])
    respond_with post.comments.create(body: comment_params[:body])
  end

  def destroy
    respond_with Comment.destroy(params[:id])
  end

  private

  def comment_params
    params.require(:comment).permit %i(body post_id)
  end
end
