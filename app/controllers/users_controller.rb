class UsersController < ApplicationController
  skip_before_action :authenticate_logged_in, only: [:new, :create]

  def new
  end

  def show
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to "/sessions/new"
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to "/users/new"
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_edit_params)
      redirect_to "/users/#{@user.id}"
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to "/users/#{@user.id}/edit"
    end
  end

  def destroy
    if current_user.id == params[:id]
      current_user.destroy
    end
    session[:user_id] = nil
    redirect_to "/users/new"
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  def user_edit_params
    params.require(:user).permit(:name, :email)
  end
end
