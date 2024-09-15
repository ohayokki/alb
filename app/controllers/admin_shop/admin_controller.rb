class AdminShop::AdminController < ApplicationController
  before_action :shop_signed_in?

  def index
  end
end
