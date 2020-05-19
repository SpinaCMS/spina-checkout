module Spina
  module Checkout
    class DeliveryDateController < CheckoutController
    
      def show
        date = current_order.soonest_delivery_date
        date_in_words = if date == Date.tomorrow
          "morgen, #{l(date, format: "%d %B")}"
        elsif date
          l(date, format: "%A %d %B")
        end
        render json: {date: date_in_words}
      end
    
    end
  end
end