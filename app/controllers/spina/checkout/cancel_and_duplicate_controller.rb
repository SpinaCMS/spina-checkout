module Spina
  module Checkout
    class CancelAndDuplicateController < CheckoutController
      before_action :set_order
    
      def create
        @order.transition_to!(:cancelled, user: @order.billing_name, ip_address: request.remote_ip)
        session[:order_id] = @order.duplicate&.id
        redirect_to wizard_path(:payment)
      end
      
      private
      
        def set_order
          @order = current_order
        end
    
    end
  
  end
end