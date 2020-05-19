Spina::Checkout::Engine.routes.draw do

  resources :success, controller: "success", only: [:show]

  resource :cancel_and_duplicate, controller: "cancel_and_duplicate"
  resources :order_items
  
  resource :delivery_date, controller: "delivery_date"

  # Sidebar specific controllers
  namespace :sidebar do
    resource :summary, controller: 'summary', only: [:show]
    resource :discount
    resources :order_items
  end
  
  # Wizard (route with least priority)
  resources :wizard, path: '/'
end
