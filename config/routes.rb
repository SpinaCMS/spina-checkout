Spina::Checkout::Engine.routes.draw do
  resources :order_items, only: [:destroy, :update]

  resources :checkout, path: '/' do
    collection do
      post :cancel_and_duplicate
    end
  end

end
