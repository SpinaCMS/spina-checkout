module Spina
  module Checkout
    class CodesController < CheckoutController
      before_action :current_order_building?

      def new
      end

      def create
        if discount.present?
          current_order.update(discount: discount)
        elsif gift_card && !current_order.gift_cards.include?(gift_card)
          current_order.gift_cards << gift_card
          current_order.save
        end
        redirect_back(fallback_location: wizard_path(:details))
      end

      private

        def current_order_building?
          raise unless current_order.building?
        end

        def discount
          @discount ||= Spina::Shop::Discount.active.find_by(code: params[:code])
        end

        def gift_card
          @gift_card ||= Spina::Shop::GiftCard.available.find_by(code: code_param)
        end

        def code_param
          params[:code].gsub(/\s|-/, "")
        end

    end
  end
end