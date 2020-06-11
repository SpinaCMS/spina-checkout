module Spina
  module Checkout
    class SuccessController < CheckoutController      
      before_action :set_order
      before_action :redirect_if_building
      before_action :duplicate_if_failed_or_cancelled
    
      def show
        # Reset the current order
        session[:order_id] = nil
      end

      # When the order is still just confirming, keep reloading this page until the order's state changes
      def waiting
        redirect_to success_path(params[:id]) if @order.received?
      end
      
      private
      
        # Get the order by /success/:id where :id stands for a unique order token
        def set_order
          @order = Spina::Shop::Order.find_by(token: params[:id])
        end

        def redirect_if_building
          redirect_to wizard_path(:shopping_cart) and return if @order.building?  
        end

        # If the order was cancelled or failed,
        # set the duplicated order as the current order
        def duplicate_if_failed_or_cancelled
          if @order.failed? || @order.cancelled?
            session[:order_id] = @order.duplicate&.id
            redirect_to wizard_path(:overview) and return
          end
        end
    
    end
  end
end