module Spina::Checkout
  class OrderItemsController < ApplicationController

    before_action :set_order
    before_action :raise_exception_if_order_is_not_building

    def destroy
      @order_item = @order.order_items.find(params[:id])
      @order_item.destroy
      redirect_to checkout_path('shopping_cart', locale: I18n.locale)
    end

    private

      def set_order
        @order = current_order
      end

      def raise_exception_if_order_is_not_building
        raise Spina::Shop::Errors::OlderAlreadyReceived unless @order.building?
      end

  end
end
