module Spina
  module Checkout
    module ApplicationHelper

      def countries_for_select
        if current_customer.try(:country)
          @countries_for_select = [[current_customer.country.name, current_customer.country.id]]
        else
          @countries_for_select = Spina::Shop::Country.order(:name).map { |country| [country.name, country.id] }
        end
      end

      def payment_options_for_order(order)
        payment_options = %w(ideal)
        payment_options
      end

    end
  end
end
