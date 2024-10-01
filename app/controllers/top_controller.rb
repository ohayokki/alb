class TopController < ApplicationController
  def index
    @title = "全国"
    @notices = Notice.order("date desc").limit(20).includes(:shop)
    if params[:search].present?
      @shops = Shop.search_by_term(params[:search])
    else
      @new_shops = Shop.includes(:area, :genre, :staffs)
      .where(status: [:無料掲載, :お試し有料掲載, :有料掲載])
      .order(Arel.sql("CASE 
                          WHEN status = 4 THEN 1  -- 有料掲載
                          WHEN status = 3 THEN 2  -- お試し有料掲載
                          WHEN status = 2 THEN 3  -- 無料掲載
                        END"), "created_at DESC")
      .limit(25)
      @shops = near_shop
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
