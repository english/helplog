class SessionsController < ApplicationController
  before_action -> { redirect_to root_path if session[:current_user] }, only: %i( new create )

  def new
  end

  def destroy
    session[:current_user] = nil
    redirect_to root_path
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:current_user] = user.id
      redirect_to root_path
    else
      render :new, error: 'Invalid email or password'
    end
  end
end
