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
                    :header_color
         
    # Default colors
    self.header_color = '#fff'
    
    self.brand_color = '#666'
    self.brand_dark_color = '#333'
    
    self.button_color = '#999'
    self.button_hover_color = '#666'
  end
end
