class SessionsController < ApplicationController
  skip_before_action :authenticate_logged_in, only: [:new, :create]
  def new
    # render login page
  end
  def create
      # Log User In
      @user = User.find_by_email(params[:user][:email]).try(:authenticate, params[:user][:password])
      if @user
        session[:user_id] = @user.id
        redirect_to "/users/#{@user.id}"
      else
        flash[:errors] = ["Invalid Combination"]
        redirect_to "/sessions/new"
      end
  end
  def destroy
      # Log User out
      session[:user_id] = nil
      redirect_to "/sessions/new"
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
