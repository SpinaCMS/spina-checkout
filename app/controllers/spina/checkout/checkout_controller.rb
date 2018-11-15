module Spina::Checkout
  class CheckoutController < ApplicationController
    layout 'spina/checkout/application'

    helper Spina::Checkout::ApplicationHelper
    
    include Wicked::Wizard

    steps :shopping_cart, :details, :delivery, :payment, :overview, :success

    def show
      case step
      when :overview
        @order = current_order
        redirect_to wizard_path(:shopping_cart) and return unless @order.everything_valid?
      when :success
        # @order = Spina::Shop::Order.find_by(id: session[:order_id])
        # redirect_to wizard_path(:shopping_cart) and return if @order.blank? || @order.building?

        # If the order failed, duplicate it and try again.
        # Otherwise clear the session and show the success page.
        # Payment could still be pending, communicate accordingly.
        # if @order.failed? || @order.cancelled?
        #   session[:order_id] = @order.duplicate.try(:id)
        #   flash[:error] = t("spina.checkout.payment_failed_try_again")
        #   redirect_to wizard_path(:overview) and return
        # else
        #   session[:order_id] = nil
        # end
      else
        @order = current_order
        redirect_to wizard_path(:overview) and return unless @order.building?
      end
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

    def cancel_and_duplicate
      @order = current_order
      @order.transition_to!(:cancelled, user: @order.billing_name, ip_address: request.remote_ip)
      session[:order_id] = @order.duplicate.try(:id)
      redirect_to wizard_path(:shopping_cart)
    end

    private

      def order_params
        params.require(:order).permit(:company, :email, :phone, :first_name, :last_name, :billing_country_id, :billing_street1, :billing_city, :billing_house_number, :billing_house_number_addition, :billing_postal_code, :separate_delivery_address, :delivery_name, :delivery_country_id, :delivery_postal_code, :delivery_street1, :delivery_city, :delivery_house_number, :delivery_house_number_addition, :delivery_option_id, :payment_method, :reference, order_items_attributes: [:quantity, :id])
      end

  end
end