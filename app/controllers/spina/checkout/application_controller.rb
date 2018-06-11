module Spina
  module Checkout
    class ApplicationController < ActionController::Base
      protect_from_forgery with: :exception

      include Shop::CurrentOrder
    end
  end
end
