Rails.application.routes.draw do
  mount Spina::Checkout::Engine => "/spina-checkout"
end
