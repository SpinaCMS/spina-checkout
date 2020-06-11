Spina::Checkout::Engine.routes.draw do

  # Success page!
  resources :success, controller: "success", only: [:show] do
    member do
      # Waiting for payment processing
      get :waiting
    end
  end

  # Canceling order
  resource :cancel_and_duplicate, controller: "cancel_and_duplicate"

  # Shopping cart
  resources :order_items
  resource :empty_cart, controller: "empty_cart", only: [:destroy]
  
  # Delivery date
  resource :delivery_date, controller: "delivery_date"

  # Discounts & giftcards
  resources :codes
  resources :gift_cards, only: [:destroy]
  resource :discount, only: [:destroy]

  # Sidebar specific controllers
  namespace :sidebar do
    # Fetch summary using javascript to speed up checkout
    resource :summary, controller: 'summary', only: [:show]

    # Infinite scrolling of order items in sidebar
    resources :order_items
  end

  # Login
  get :login, to: 'sessions#new'
  post :login, to: 'sessions#create'
  delete :logout, to: 'sessions#destroy'
  
  # Wizard (route with least priority)
  resources :wizard, path: '/'
end
