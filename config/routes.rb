Spina::Checkout::Engine.routes.draw do

  resources :success, controller: "success", only: [:show]

  resources :wizard, path: '/'

  resource :cancel_and_duplicate, controller: "cancel_and_duplicate"
  resources :order_items

  # Sidebar specific controllers
  namespace :sidebar do
    resource :summary, controller: 'summary', only: [:show]
    resource :discount
    resources :order_items
  end

end
