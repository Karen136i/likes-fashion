Rails.application.routes.draw do
  # 顧客用
  devise_for :customers, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }
  #ゲストログイン
  devise_scope :customer do
    post "/public/guest_sign_in", to: "public/sessions#guest_sign_in"
  end

  root to: 'public/homes#top'
  get '/about', to: 'public/homes#about', as: 'about'

  namespace :admin do
    resources :order_details, only: [:update]
    resources :orders, only: [:show, :update]
    resources :customers, only: [:index, :show, :edit, :update] # ここでcustomersリソースを定義
    resources :categories, only: [:index, :create, :edit, :update, :destroy]
    resources :items, only: [:index, :new, :create, :show, :edit, :update, :destroy]
    resources :sessions, only: [:new, :create, :destroy]
    resources :homes, only: [:top]
    resources :comments, only: [:new, :create, :edit, :update, :destroy]
  end

  namespace :public do
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :update, :destroy, :create] do
      get 'cart_items', to: 'cart_items#index'
      post 'cart_items', to: 'cart_items#create' # 追加: cart_items#createを処理するルートを追加
    end
    delete 'cart_items', to: 'cart_items#destroy_all', as: "cart_items_all_destroy"

    resources :customers, only: [:show, :edit, :update] do
      member do
        get :unsubscribe
        delete :withdraw
      end
    end

    resources :orders, only: [:new, :confirm, :thanks, :create, :index, :show]
    resources :addresses, only: [:index, :edit, :update, :create, :destroy]
    resources :reviews, only: [:new, :show, :update, :create, :destroy]
    resources :favorites, only: [:index, :create, :destroy]
    resources :categories, only: [:show]
    post 'orders', to: 'orders#confirm', as: 'order_confirm'
    get 'orders', to: 'orders#thanks', as: 'order_thanks'
  end
end
