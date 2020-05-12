module Spina
  module Checkout
    class WizardController < CheckoutController
      include Wicked::Wizard

      steps :shopping_cart, :details, :delivery, :payment, :overview

      def show
        @order_items = current_order.order_items.order(:id).limit(11)

        render_wizard
      end

      def update
        render_wizard current_order
      end

    end
  end
end