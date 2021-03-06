module Spina
  module Checkout
    class EmptyCartController < CheckoutController
      before_action :current_order_building?

      def destroy
        current_order.order_items.destroy_all
        redirect_to wizard_path(:shopping_cart)
      end

      private

        def current_order_building?
          raise unless current_order.building?
        end

    end
  end
end