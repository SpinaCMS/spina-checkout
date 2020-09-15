module Spina
  module Checkout
    class WizardController < CheckoutController
      include Wicked::Wizard
      
      layout 'spina/checkout/wizard'
      
      before_action :redirect_to_root
      before_action :redirect_to_overview
      before_action :set_defaults

      steps :shopping_cart, :details, :delivery, :payment, :overview

      def show
        render_wizard
      end

      def update
        prepare_validation!
        
        case step
        when :details, :delivery, :payment
          current_order.assign_attributes(order_params)
          additional_updates
        when :overview
          begin
            current_order.transition_to!(:confirming, transition_metadata)
            redirect_to current_order.payment_url and return
          rescue Statesman::GuardFailedError
            redirect_to wizard_path(:shopping_cart) and return
          end
        end
        
        render_wizard current_order
      end

      def additional_updates
        # Placeholder method
        # Do some custom stuff in your main app if you want
      end

      private
        
        def order_params
          detail_params.merge(delivery_params).merge(payment_params)
        end
        
        def detail_params
          params.require(:order).permit(
            :email, 
            :first_name, :last_name, 
            :date_of_birth, 
            :separate_delivery_address, 
            :billing_street1, :billing_street2, 
            :billing_house_number, :billing_house_number_addition, 
            :billing_postal_code, :billing_city, :billing_country_id, 
            :delivery_first_name, :delivery_last_name,
            :delivery_street1, :delivery_street2,
            :delivery_house_number, :delivery_house_number_addition,
            :delivery_postal_code, :delivery_city, :delivery_country_id
          )
        end
        
        def delivery_params
          params.require(:order).permit(:delivery_option_id)
        end
        
        def payment_params
          params.require(:order).permit(:payment_method, :payment_issuer)
        end
        
        def redirect_to_root
          redirect_to '/' and return unless current_order
        end
        
        # If the order is already confirming, redirect to the overview page (unless already there)
        def redirect_to_overview
          if current_order.confirming?
            redirect_to wizard_path(:overview) and return unless step == :overview
          end
        end

        def set_defaults
          current_order.delivery_option_id ||= current_order.delivery_options.first.id
          current_order.payment_method ||= current_order.payment_methods.first
        end

        def prepare_validation!
          case step
          when :shopping_cart
            current_order.validate_stock = true
          when :details
            current_order.validate_details = true
          when :delivery
            current_order.validate_delivery = true
          when :payment
            current_order.validate_payment = true
          end
        end
        
        def transition_metadata
          {user: current_order.billing_name, ip_address: request.remote_ip}
        end

    end
  end
end