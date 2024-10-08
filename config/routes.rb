require 'sidekiq/web'
Rails.application.routes.draw do
  devise_for :admin_users #先頭行

  #Sidekiq管理画面にBasic認証を追加する
  mount Sidekiq::Web => '/sidekiq' if Rails.env.development?
  
  # Sidekiqの Basic Authentication
  if Rails.env.production?
    Sidekiq::Web.use(Rack::Auth::Basic) do |username, password|
      username == ENV['BASIC_AUTH_USERNAME'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "prefectures/:id", to: "prefectures#index", as: :prefectures
  get "districts/:id", to: "districts#index", as: :districts
  get "privacy-policy", to: "top#privacy_policy", as: :privacy_policy #プライバシーポリシー
  get "terms-of-use", to: "top#terms", as: :terms #プライバシーポリシー
  get "shop_request_confirm", to: "contacts#shop_request_confirm",as: :shop_request_confirm #お店登録申請後の結果画面

  #　店舗ログイン関係
  get "shop_login", to: "shops#login", as: :shop_login
  post "shop_login", to: "shops#login_process"
  delete "shop_logout", to: "shops#logout", as: :shop_logout
  # 店舗管理
  namespace :admin_shop do
    get "admin/index"
    resources :holidays, except: [:new]
    resources :shops, only: [:update] do
      patch :set_vacant, on: :member # 空席中の処理
      delete :remove_vacant, on: :member # 空席中の処理
    end
    resources :staffs, except: [:new] do
    end
    resources :comments, only: [:destroy, :update]
    resources :notices, except: [:new]
    resources :labels, only: [:create]
    get "shop-edit", to: "admin#shopedit", as: :shopedit
    get "coupon-edit", to: "admin#coupon", as: :coupon
    get "shop-image", to: "admin#images", as: :images
    get "shop-tag", to: "admin#labels", as: :tag
    get "shop-comment", to: "admin#comments", as: :comments
    get "sns", to: "admin#sns", as: :sns
  end

  # 管理者用
  namespace :admin do
    get "contacts/index"
    resources :shops, except: [:new, :edit, :create] do
      member do
        get :status_change
      end
    end
    resources :areas, only: [:new, :create, :edit, :update] do
      get 'prefectures', on: :collection
      get 'districts', on: :collection
    end
    resources :contacts, only: [:index, :update]
  end
  get "genre/:genre/:area", to: "genres#area", as: :genre_area
 
  resources :contacts, only: [:index] do
    collection do
      get :post_request
    end
  end

  resources :shops, only: [:create, :show]
  resources :areas, only: [:show]
  resources :staffs, only: [:show]

  #口コミ用
  resources :user_comments, only: [:create, :update, :destroy]

  # 地域選択用
  get 'districts/by_prefecture/:prefecture_id', to: 'districts#by_prefecture', as: 'districts_by_prefecture'
  get 'areas/by_district/:district_id', to: 'admin/areas#by_district', as: 'areas_by_district'

  # ユーザセッション関係
  # OmniAuthコールバック用のルート
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: redirect('/')
  delete '/logout', to: 'sessions#destroy'
  get "login", to: "sessions#login"
  get "line-login", to: "sessions#line_login", as: :line_login
  #user
  get "users", to: "users#show", as: :user_page
  #位置情報をセッションに保存
  post 'save_location', to: 'top#save_location'
  resources :relationships, only: [:create, :destroy]

  #問い合わせ関係
  resources :contacts, only: [:new, :create]
  get 'thanks', to: 'contacts#thanks', as: 'thanks_contacts'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest








  ### i18n済
  scope "(:locale)", locale: /ja|en/ do
    root "top#index"
  end
end
