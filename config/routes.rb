Spina::Checkout::Engine.routes.draw do
  resources :order_items, only: [:destroy, :update]

  resources :checkout, path: '/'
end
