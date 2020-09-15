module Spina
  module Checkout
    class DiscountsController < CheckoutController
      before_action :current_order_building?

      def destroy
        current_order.update(discount: nil)
        render js: "document.querySelector('.sidebar-summary').controller.fetchSummary(); document.querySelector('.sidebar-products').controller.fetchProductList()"
      end

      private

        def current_order_building?
          raise unless current_order.building?
        end

    end
  end
end