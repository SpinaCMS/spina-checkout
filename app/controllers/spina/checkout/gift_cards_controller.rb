module Spina
  module Checkout
    class GiftCardsController < CheckoutController
      before_action :current_order_building?

      def destroy
        @gift_card = current_order.gift_cards.find(params[:id])
        current_order.gift_cards.delete(@gift_card)
        current_order.save
        redirect_back fallback_location: wizard_path(:payment)
      end

      private

        def current_order_building?
          raise unless current_order.building?
        end

    end
  end
end