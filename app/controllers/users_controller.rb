class UsersController < ApplicationController
  def show
    @user = current_user
    @comments = @user.user_comments.includes(:shop)
    @followings = @user.shops.includes(:genre, :staffs, :area)
  end
end
