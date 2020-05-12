module Spina
  module Checkout
    module Sidebar
      class SummaryController < CheckoutController

        def show
          render layout: false
        end

      end
    end
  end
end