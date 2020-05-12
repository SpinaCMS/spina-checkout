module Spina
  module Checkout
    module Sidebar
      class OrderItemsController < CheckoutController

        def index
          @order_items = current_order.order_items.order(:id).page(params[:page]).per(11)
        end

      end
    end
  end
end