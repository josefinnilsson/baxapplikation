Rails.application.routes.draw do

  resources :orders
  resources :purchases do
    collection do
      get 'remove_all'
    end
  end
  resources :users do
    member do
      get '/purchases', to: 'users#purchases'
      post "/set_admin"   => "users#set_admin",   :as => :make_user_admin
      post "/delete_purchases" => "users#delete_purchases", :as => :delete_purchases
    end
  end
  resources :products
  resources :requests
  resources :payments
  resources :orders
  resources :outlays
  resources :whitelists


  get 'sessions/new'

  get 'admins', to: 'static_pages#admins'

  root 'static_pages#home'
  get  'static_pages/makeawish'
  get  '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/baxbollstoppen', to: 'users#baxbollstoppen'
  get '/alkoholtoppen', to: 'users#alkoholtoppen'

  get "/404", :to => "errors#not_found"
  get "/422", :to => "errors#unacceptable"
  get "/500", :to => "errors#internal_error"
end
