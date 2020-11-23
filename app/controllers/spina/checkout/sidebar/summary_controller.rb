module Spina
  module Checkout
    module Sidebar
      class SummaryController < CheckoutController
        before_action :set_defaults, if: -> { Spina::Checkout.config.use_default_delivery_option }

        def show
          render layout: false
        end

      end
    end
  end
end