class GroupsController < ApplicationController
  before_filter :authenticate

  def create
    user = User.find_by_email(params[:group][:leader_id])
    current_user.follow!(@user)
    redirect_to @user
  end

  def destroy
    @user = Group.find(params[:id]).followed
    current_user.unfollow!(@user)
    redirect_to @user
  end

end