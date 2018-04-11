class LikesController < ApplicationController
  def create
    @like = Like.find_or_create_by(user: current_user, secret: Secret.find(params[:id]))
    redirect_to "/secrets"
  end

  def destroy
    @like = Like.find_by(user: current_user, secret: Secret.find(params[:id]))
    @like.destroy if @like
    redirect_to "/secrets"
  end
end
