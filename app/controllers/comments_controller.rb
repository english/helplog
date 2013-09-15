class CommentsController < ApplicationController
  respond_to :json

  def index
    respond_with Comment.all
  end

  def create
    comment = params[:comment]
    respond_with Post.find(comment[:post]).comments.create(body: comment[:body])
  end

  private

  def comment_params
    params.require(:comment).permit %i(body post)
  end
end
