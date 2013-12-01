class CommentsController < ApplicationController
  respond_to :json
  before_action :authenticate, only: :destroy

  def index
    respond_with Comment.all
  end

  def create
    respond_with Comment.create(comment_params)
  end

  def destroy
    respond_with Comment.destroy(params[:id])
  end

  private

  def comment_params
    params.require(:comment).permit %i(body author post_id)
  end
end
