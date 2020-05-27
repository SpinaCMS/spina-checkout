module Spina
  module Checkout
    class CheckoutController < ActionController::Base      
      protect_from_forgery with: :exception
      
      layout 'spina/checkout/checkout'

      private

        def current_customer
          @current_customer ||= current_order&.customer
        end
        helper_method :current_customer

        def current_order
          @current_order ||= Spina::Shop::Order.in_state(:building, :confirming).find_by(id: session[:order_id])
        end
        helper_method :current_order
        
    end
  end
end
