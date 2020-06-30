module Spina::Checkout
  class ExistingCustomerAccountController < CheckoutController

    def create
      @customer_account = Spina::Shop::CustomerAccount.find_by(email: params[:email])

      if @customer_account.present?
        render layout: false
      else
        head :not_found 
      end
    end

  end
end