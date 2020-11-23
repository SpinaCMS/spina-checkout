require "spina/checkout/engine"
require "spina/checkout/railtie"
require "wicked"

module Spina
  module Checkout
    include ActiveSupport::Configurable
    
    config_accessor :brand_color,
                    :brand_dark_color,
                    :button_color,
                    :button_hover_color,
                    :header_color,
                    :terms_and_conditions_path,
                    :login_popup,
                    :codes_form,
                    :delivery_date_estimation,
                    :must_be_of_age,
                    :use_default_delivery_option
         
    # Default colors
    self.header_color = '#fff'
    
    self.brand_color = '#666'
    self.brand_dark_color = '#333'
    
    self.button_color = '#999'
    self.button_hover_color = '#666'

    # Default path to terms and conditions
    self.terms_and_conditions_path = nil

    # Show a popup to login if customer is not logged in yet
    self.login_popup = true

    # Add button in sidebar to add codes
    self.codes_form = true

    # Estimate delivery date in sidebar
    self.delivery_date_estimation = true

    # Must be of age = true creates a date of birth field
    self.must_be_of_age = false
    
    # Have a default delivery option on every step
    self.use_default_delivery_option = true
  end
end
