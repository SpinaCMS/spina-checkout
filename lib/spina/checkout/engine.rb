module Spina
  module Checkout
    class Engine < ::Rails::Engine
      isolate_namespace Spina::Checkout
    end
  end
end
