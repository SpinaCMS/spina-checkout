Spina::Checkout::Engine.routes.draw do

  # Success page!
  resources :success, controller: "success", only: [:show]

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
  
  # Wizard (route with least priority)
  resources :wizard, path: '/'
end
