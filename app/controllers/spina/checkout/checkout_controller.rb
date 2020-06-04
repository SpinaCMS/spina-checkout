module Spina
  module Checkout
    class CheckoutController < ActionController::Base
      include Spina::Shop::CurrentOrder

      protect_from_forgery with: :exception
      
      layout 'spina/checkout/checkout'
    end
  end
end
