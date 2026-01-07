module Spina
  module Checkout
    class DiscountsController < CheckoutController
      before_action :current_order_building?

      def destroy
        current_order.update(discount: nil)
        redirect_back fallback_location: wizard_path(:shopping_cart)
      end

      private

        def current_order_building?
          raise unless current_order.building?
        end

    end
  end
end
