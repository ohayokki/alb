class UsersController < ApplicationController
  def show
    @user = current_user
    @comments = @user.user_comments
  end
end
