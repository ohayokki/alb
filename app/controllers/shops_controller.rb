class ShopsController < ApplicationController
  before_action :set_shop, only: [:show]

  def create
    @shop = Shop.new(shop_params)
    @shop.status = "掲載依頼"
    if @shop.save
      redirect_to shop_request_confirm_path
    else
      flash.now[:danger] = 'ショップの作成に失敗しました。'
      render "contacts/post_request", status: :unprocessable_entity
    end
  end

  def show
  end

  def login
    if shop_obj
      redirect_to admin_shop_admin_index_url
    end
  end

  def login_process
    email = params[:session][:email].downcase
    password = params[:session][:password]
    if shop_login(email, password)
      redirect_to admin_shop_admin_index_url
    else
      flash.now[:danger] = "ログインできませんでした。"
      render "shops/login",  status: :unprocessable_entity
    end
  end

  def logout
    session[:shop_id] = nil
    flash[:success] = "店舗アカウントからログアウトしました。"
    redirect_to shop_login_url
  end

  private

  def set_shop
    @shop = Shop.find(params[:id])
  end

  def shop_login(email, password)
    @shop = Shop.find_by(email: email)
    if @shop && @shop.authenticate(password)
      # ログイン成功
      session[:shop_id] = @shop.id
      return true
    else
      # ログイン失敗
      return false
    end
  end

  def shop_params
    params.require(:shop).permit(
      :manager_name, :name, :address, :genre_id, :access, :area_description, :hours, :budget,
      :title, :introduction, :tel, :email,
      :shop_logo,
      :reservation,
      :wifi,
      :alcohol,
      :smoking,
      :english,
      :korean,
      :card_payment,
      :mobile_payment,
      :website,
      :notes,
      :coupon,
      :costume_id,
      :password, :password_confirmation,
      tag_ids: []
    )
  end
end
