class CommentsController < ApplicationController
  respond_to :json
  before_action :authenticate, only: :destroy

  def index
    respond_with Comment.all
  end

  def create
    comment = params[:comment]
    respond_with Post.find(comment[:post_id]).comments.create(body: comment[:body])
  end

  def destroy
    respond_with Comment.destroy(params[:id])
  end

  private

  def comment_params
    params.require(:comment).permit %i(body post)
  end
end
