module Spina
  module Checkout
    class OrderItemsController < CheckoutController
      before_action :current_order_building?

      def update
        @order_item = current_order.order_items.find(params[:id])
        @order_item.update(quantity: params[:quantity])
        head :ok
      end

      def destroy
        @order_item = current_order.order_items.find(params[:id])
        @order_item.destroy
        redirect_to wizard_path(:shopping_cart)
      end

      private

        def current_order_building?
          raise unless current_order.building?
        end

    end
  end
end