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
  get "/search", to: "searches#search"

  namespace :admin do
    resources :order_details, only: [:update]
    resources :orders, only: [:index, :show, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :categories, only: [:index, :create, :edit, :update, :destroy]
    resources :items, only: [:index, :new, :create, :show, :edit, :update, :destroy]
    resources :reviews, only: [:index, :create, :show, :destroy] do 
      resources :comments,only:[:new, :create]
    end
    resources :sessions, only: [:new, :create, :destroy]
    resources :homes, only: [:top]
    resources :comments, only: [:edit, :update, :destroy]

  end

  namespace :public do
    resources :items, only: [:index, :show]
       resource :favorites, only: [:create, :destroy]
    resources :favorites, only: [:index]
    resources :reviews, only: [:index, :new, :show, :update, :create, :destroy] 
       resource :review_favorites, only: [:create, :destroy]
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
    resources :categories, only: [:show]
    get 'orders/confirm', to: 'orders#confirm'
    post 'orders/confirm', to: 'orders#confirm'
    get 'orders/thanks', to: 'orders#thanks'
    get 'orders/:id', to: 'orders#show'

  end
end
