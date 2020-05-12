Spina::Checkout::Engine.routes.draw do

  resources :wizard, path: '/'

  resources :order_items

  # Sidebar specific controllers
  namespace :sidebar do
    resource :summary, controller: 'summary', only: [:show]
    resource :discount
    resources :order_items
  end

end
