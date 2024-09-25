class TopController < ApplicationController
  def index
    @title = "全国"
    if params[:search].present?
      @shops = Shop.search_by_term(params[:search])
    else
      @new_shops = Shop.includes(:area, :genre).order("created_at desc").where(status: ["無料掲載", "有料掲載", "お試し有料掲載"]).limit(25)
      near_shop
    end
  end

  def privacy_policy
  end

  def terms
  end
  def save_location
    session[:latitude] = params[:latitude]
    session[:longitude] = params[:longitude]
    head :ok
  end
end
