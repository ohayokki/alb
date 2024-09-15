module SessionsHelper
  def shop_obj
    @shop_obj ||= Shop.find_by(id: session[:shop_id])
  end

  def shop_logged_in?
    !!shop_obj
  end
end
