module Spina
  module Shop
    class Railtie < Rails::Railtie

      initializer "spina_shop.assets.precompile" do |app|
        app.config.assets.precompile += %w(spina_checkout_manifest.js)
      end

    end
  end
end