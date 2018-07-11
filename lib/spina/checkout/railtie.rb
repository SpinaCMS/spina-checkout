module Spina
  module Shop
    class Railtie < Rails::Railtie

      initializer "spina_shop.assets.precompile" do |app|
        app.config.assets.precompile += %w(spina/checkout/payment_options/*.svg spina/checkout/*.svg)
      end

    end
  end
end