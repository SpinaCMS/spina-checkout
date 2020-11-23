module Spina
  module Checkout
    class CheckoutController < ActionController::Base
      include Spina::Shop::CurrentOrder

      protect_from_forgery with: :exception
      
      layout 'spina/checkout/checkout'
      
      private
      
        def set_defaults
          current_order.delivery_option_id ||= current_order.delivery_options.first.id
          current_order.payment_method ||= current_order.payment_methods.first
        end
        
    end
  end
end
