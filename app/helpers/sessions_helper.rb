module SessionsHelper
  def shop_obj
    @shop_obj ||= Shop.find_by(id: session[:shop_id])
  end

  def shop_logged_in?
    !!shop_obj
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def user_signed_in?
    !!current_user
  end
end
