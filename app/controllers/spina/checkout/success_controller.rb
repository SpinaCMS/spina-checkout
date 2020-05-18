module Spina
  module Checkout
    class SuccessController < CheckoutController
      before_action :set_order
    
      def show
        redirect_to wizard_path(:shopping_cart) if @order.building?
      end
      
      private
      
        # Get the order by /success/:id where :id stands for a unique order token
        def set_order
          @order = Spina::Shop::Order.find_by(token: params[:id])
        end
    
    end
  end
end