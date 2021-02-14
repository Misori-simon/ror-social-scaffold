class FriendshipsController < ApplicationController
  def new_request
    current_user.request_friend(friendship_params[:friend_id])
    redirect_to users_path
  end

  def accept_request
    current_user.accept_friend(friendship_params[:friend_id])
    redirect_to users_path
  end

  def decline_request
    current_user.decline_friend(friendship_params[:friend_id])
    redirect_to users_path
  end

  private

  def friendship_params
    params.permit(:friend_id)
  end
end
