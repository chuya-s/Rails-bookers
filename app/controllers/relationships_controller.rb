class RelationshipsController < ApplicationController
  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end

  def destroy
      current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

  def followings
    @users = Relationship.where(follower_id:params[:user_id])
  end

  def followers
    @users = Relationship.where(followed_id:params[:user_id])
  end
end
