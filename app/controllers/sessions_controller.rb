class SessionsController < ApplicationController
  def destroy
    session[:current_user] = nil
    render json: {}, status: :accepted
  end

  def create
    user = User.find_by_email(session_params[:email])

    if user && user.authenticate(session_params[:password])
      session[:current_user] = user.id
      render json: { session: { id: 'current', active: true } }
    else
      render json: {
        errors: { email: 'invalid email or password' }
      }, status: :unprocessable_entity
    end
  end

  def show
    render json: {
      session: { id: 'current', active: logged_in? }
    }
  end

  def new
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
