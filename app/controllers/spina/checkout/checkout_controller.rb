module Spina::Checkout
  class CheckoutController < ApplicationController
    include Wicked::Wizard

    helper ApplicationHelper

    steps :shopping_cart, :details, :delivery, :payment, :overview, :success

    def show
      @order = current_order
      render_wizard
    end

    def update
      @order = current_order

      case step
      when :shopping_cart
        @order.validate_stock = true
      when :details
        @order.validate_details = true
      when :delivery
        @order.validate_delivery = true
      when :payment
        @order.validate_payment = true
      when :overview
        # Confirm order!
        @order.transition_to(:confirming, user: @order.billing_name, ip_address: request.remote_ip)

        if @order.confirming?
          if @order.nothing_owed?
            @order.transition_to(:received, user: @order.billing_name, ip_address: request.remote_ip)
            @order.transition_to(:paid, user: @order.billing_name, ip_address: request.remote_ip)
            redirect_to checkout_path('success', locale: I18n.locale) and return
          else
            redirect_to @order.payment_url and return
          end
        else
          redirect_to checkout_path('shopping_cart', locale: I18n.locale) and return
        end
      end

      @order.update_attributes(order_params) if params[:order].present?
      render_wizard @order
    rescue ActiveRecord::RecordInvalid
      redirect_to checkout_path('shopping_cart', locale: I18n.locale)
    end

    private

      def order_params
        params.require(:order).permit(:company, :email, :phone, :first_name, :last_name, :billing_country_id, :billing_street1, :billing_city, :billing_house_number, :billing_house_number_addition, :billing_postal_code, :separate_delivery_address, :delivery_name, :delivery_country_id, :delivery_postal_code, :delivery_street1, :delivery_city, :delivery_house_number, :delivery_house_number_addition, :delivery_option_id, :payment_method, :reference)
      end

  end
end