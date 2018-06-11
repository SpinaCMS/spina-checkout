module Spina
  module Checkout
    class ApplicationRecord < ActiveRecord::Base
      self.abstract_class = true
    end
  end
end
