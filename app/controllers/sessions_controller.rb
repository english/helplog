class SessionsController < ApplicationController
  def destroy
    session[:current_user] = nil
    render json: {}, status: :accepted
  end

  def create
    user = User.find_by_email(params[:session][:email])

    if user && user.authenticate(params[:session][:password])
      puts 'in'
      session[:current_user] = user.id
      render json: { session: { id: 'current', active: true } }
    else
      puts 'out'
      render json: {
        errors: {
          email: 'invalid email or password'
        }
      }, status: :unprocessable_entity
    end
  end

  def show
    render json: {
      session: { id: 'current', active: logged_in? }
    }
  end
end
