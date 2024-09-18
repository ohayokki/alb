class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  include SessionsHelper
  def set_user
    current_user = User.find(1)
    session[:user_id] = current_user.id
  end

end
