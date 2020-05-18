Spina::Checkout::Engine.routes.draw do

  resources :wizard, path: '/'
  
  get :waiting, to: 'wizard#waiting'
  get :success, to: 'wizard#success'

  resources :order_items

  # Sidebar specific controllers
  namespace :sidebar do
    resource :summary, controller: 'summary', only: [:show]
    resource :discount
    resources :order_items
  end

end
