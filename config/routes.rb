Rails.application.routes.draw do
  

  devise_for :customers
  devise_for :admins
  root to: 'public/homes#top'
  get '/about', to: 'public/homes#about', as: 'about'
  
  namespace :admin do
    resources :order_details, only: [:update]
    resources :orders, only: [:show, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :categories, only: [:index, :create, :edit, :update]
    resources :items, only: [:index, :new, :create, :show, :edit, :update, :destroy]
    resources :sessions, only: [:new, :create, :destroy]
    resources :homes, only: [:top]
    resources :comments, only: [:new, :create, :edit, :update, :destroy]
  end
   
  namespace :public do
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :update, :destroy] do
      delete 'cart_items', to: 'cart_items#destroy_all'
      get 'cart_items', to: 'cart_items#index'
    end
  
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
  end

end
