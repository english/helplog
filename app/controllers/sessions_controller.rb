class SessionsController < ApplicationController
  def new
  end

  def destroy
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.save
      redirect_to new_post_path
    else
      render :new
    end
  end
end
