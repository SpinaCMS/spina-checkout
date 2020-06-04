module Spina::Checkout
  class SessionsController < CheckoutController
    before_action :check_logged_in, only: [:new, :create]

    def new
    end

    def create
      @customer_account = Spina::Shop::CustomerAccount.find_by(email: params[:email])

      if @customer_account.authenticate(params[:password])
        login(@customer_account)
        redirect_back(fallback_location: wizard_path(:shopping_cart))        
      else
        render :wrong_login
      end
    end

    def destroy
      session[:customer_account_id] = nil
      session[:order_id] = nil
      redirect_back(fallback_location: wizard_path(:shopping_cart))
    end

    private

      def check_logged_in
        redirect_to wizard_path(:shopping_cart) and return if logged_in?
      end

  end
end