module Spina
  module Checkout
    module Sidebar
      class OrderItemsController < CheckoutController

        def index
          @order_items = current_order.order_items.order(:id).page(params[:page]).per(11)

          respond_to do |format|
            format.js
            format.html { render layout: false }
          end
        end

      end
    end
  end
end